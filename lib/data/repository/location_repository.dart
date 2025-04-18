import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_search_local/data/model/location.dart';

class LocationRepository {
  String vworldKey = dotenv.get("VWORLD_KEY");
  String xNaverClientId = dotenv.get("X_NAVER_CLIENT_ID");
  String xNaverClientSecret = dotenv.get("X_NAVER_CLIENT_SECRET");

  final Dio _client = Dio(
    BaseOptions(validateStatus: (status) => true, headers: {"X-Naver-Client-Id": "vworldKey", "X-Naver-Client-Secret": "xNaverClientId"}),
  );

  Future<List<Item>> fetchLocationsByKeyword(String keyword) async {
    final response = await _client.get('https://openapi.naver.com/v1/search/local.json?query=$keyword&display=5');

    if (response.statusCode == 200) {
      final items = response.data['items'];
      return (items as List).map((item) => Item.fromJson(item)).toList();
    }

    return [];
  }

  Future<String?> fetchKeywordFromGeo(double lat, double lng) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/data?request=GetFeature&data=LT_C_ADEMD_INFO&key=$xNaverClientSecret&geomfilter=point($lng%20$lat)&geometry=false&size=100',
    );

    if (response.statusCode == 200) {
      log(response.data['response']['status']);
      switch (response.data['response']['status']) {
        case "OK":
          //읍면동
          final emd = response.data['response']['result']['featureCollection']?['features'][0]['properties']['full_nm'];
          return emd;
        case "NOT_FOUND":
          return null;
        case "ERROR":
          return null;
      }
    }
    return null;
  }

  Future<List<Item>> fetchLocationsByGeo(double lat, double lng) async {
    final keyword = await fetchKeywordFromGeo(lat, lng);
    if (keyword != null) {
      return await fetchLocationsByKeyword(keyword);
    }
    return [];
  }
}
