import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_search_local/data/model/location.dart';

class LocationRepository {
  String vworldKey = dotenv.get("VWORLD_KEY");
  String xNaverClientId = dotenv.get("X_NAVER_CLIENT_ID");
  String xNaverClientSecret = dotenv.get("X_NAVER_CLIENT_SECRET");

  late final Dio _client;

  LocationRepository() {
    _client = Dio(
      BaseOptions(validateStatus: (status) => true, headers: {"X-Naver-Client-Id": xNaverClientId, "X-Naver-Client-Secret": xNaverClientSecret}),
    );
  }

  Future<List<Location>> fetchLocationsByKeyword(String keyword) async {
    final response = await _client.get('https://openapi.naver.com/v1/search/local.json?query=$keyword&display=5');
    log("fetchLocationsByKeyword ${response.statusCode}");
    if (response.statusCode == 200) {
      final items = response.data['items'];
      return (items as List).map((item) => Location.fromJson(item)).toList();
    }

    return [];
  }

  Future<String?> fetchKeywordFromGeo(double lat, double lng) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/data?request=GetFeature&data=LT_C_ADEMD_INFO&key=$vworldKey&geomfilter=point($lng%20$lat)&geometry=false&size=100',
    );

    log("fetchKeywordFromGeo ${response.statusCode}");
    if (response.statusCode == 200) {
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

  Future<List<Location>> fetchLocationsByGeo(double lat, double lng) async {
    final keyword = await fetchKeywordFromGeo(lat, lng);
    if (keyword != null) {
      return await fetchLocationsByKeyword(keyword);
    }
    return [];
  }
}
