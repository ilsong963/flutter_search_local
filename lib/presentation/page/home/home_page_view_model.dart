import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/data/repository/location_repository.dart';

class LocationSearchViewModel extends AutoDisposeNotifier<List<Item>?> {
  final locationRepository = LocationRepository();

  @override
  List<Item>? build() {
    return [];
  }

  Future<void> searchLocationsByKeyword(String keyword) async {
    final result = await locationRepository.fetchLocationsByKeyword(keyword);
    state = result;
  }

  Future<void> searchLocationsByGeo(double lat, double lng) async {
    final result = await locationRepository.fetchLocationsByGeo(lat, lng);
    state = result;
  }
}

final locationSearchViewModel = NotifierProvider.autoDispose<LocationSearchViewModel, List<Item>?>(() {
  return LocationSearchViewModel();
});
