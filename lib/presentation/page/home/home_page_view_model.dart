import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/data/repository/location_repository.dart';

class LocationSearchViewModel extends AutoDisposeNotifier<List<Item>?> {
  final locationRepository = LocationRepository();

  @override
  List<Item>? build() {
    return [];
  }

  Future<void> searchLocal(String query) async {
    final result = await locationRepository.getSearchLocalData(query);
    state = result;
  }
}

final locationSearchViewModel = NotifierProvider.autoDispose<LocationSearchViewModel, List<Item>?>(() {
  return LocationSearchViewModel();
});
