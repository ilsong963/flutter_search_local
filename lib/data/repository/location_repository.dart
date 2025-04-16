import 'package:dio/dio.dart';
import 'package:flutter_search_local/data/model/location.dart';

class LocationRepository {
  final Dio _client = Dio(
    BaseOptions(validateStatus: (status) => true, headers: {"X-Naver-Client-Id": "qqpTyfi_nXUhZSsPI0JT", "X-Naver-Client-Secret": "KqzUVCijJh"}),
  );

  Future<List<Item>> getSearchData(String keyword) async {
    final response = await _client.get('https://openapi.naver.com/v1/search/local.json?query=$keyword&display=5');

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final items = data['items'] as List<Item>;
      return items;
    }

    return [];
  }
}
