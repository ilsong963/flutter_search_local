import 'package:flutter_naver_map/flutter_naver_map.dart';

NLatLng convertVWorldToNaverLatLng(String mapx, String mapy) {
  final lat = double.parse(mapy) / 10000000;
  final lng = double.parse(mapx) / 10000000;
  return NLatLng(lat, lng);
}
