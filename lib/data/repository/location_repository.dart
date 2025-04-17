import 'package:dio/dio.dart';
import 'package:flutter_search_local/data/model/location.dart';

class LocationRepository {
  final Dio _client = Dio(
    BaseOptions(validateStatus: (status) => true, headers: {"X-Naver-Client-Id": "qqpTyfi_nXUhZSsPI0JT", "X-Naver-Client-Secret": "KqzUVCijJh"}),
  );

  Future<List<Item>> fetchLocationsByKeyword(String keyword) async {
    final response = await _client.get('https://openapi.naver.com/v1/search/local.json?query=$keyword&display=5');

    if (response.statusCode == 200) {
      final items = response.data['items'];
      return (items as List).map((item) => Item.fromJson(item)).toList();
    }

    return [];
  }

  Future<List<Item>> fetchLocationsByGeo(double lat, double lng) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/data?request=GetFeature&data=LT_C_ADEMD_INFO&key=833FB49C-4B1A-3E24-B36E-058256B640FC&geomfilter=point($lat%20 $lng)&geometry=false&size=100',
    );

    if (response.statusCode == 200) {
      final items = response.data['items'];
      return (items as List).map((item) => Item.fromJson(item)).toList();
    }

    return [];
  }
}
        // Response > result > items >> title