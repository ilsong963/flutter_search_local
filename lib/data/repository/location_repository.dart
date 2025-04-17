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

  Future<List<Item>> fetchLocationsByGeo(double lat, double lng) async {}
}
        // Response > result > items >> title