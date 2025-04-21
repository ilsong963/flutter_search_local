import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/core/util/remove_tag.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';

class LocationMarkerMap extends ConsumerStatefulWidget {
  final sharedOptionState = StreamController<NaverMapViewOptions>.broadcast()..add(const NaverMapViewOptions());

  LocationMarkerMap({super.key});

  @override
  LocationMarkerMapState createState() => LocationMarkerMapState();
}

class LocationMarkerMapState extends ConsumerState<LocationMarkerMap> {
  NaverMapController? _mapController;

  Set<NMarker> _buildMarkers(List<Item>? locations) {
    if (locations == null || locations.isEmpty) {
      return <NMarker>{};
    }
    // location의 좌표값 / 10000000
    return locations.map((location) {
      return NMarker(
        id: 'marker_${removeTag(location.title)}',
        position: NLatLng(double.parse(location.mapy) / 10000000, double.parse(location.mapx) / 10000000),
        caption: NOverlayCaption(text: removeTag(location.title)),
      );
    }).toSet();
  }

  void _updateMarkers(List<Item>? locations) {
    if (_mapController == null) return;

    // 기존 마커 제거
    _mapController!.clearOverlays();

    // 새로운 마커 추가
    final newMarkers = _buildMarkers(locations);
    _mapController!.addOverlayAll(newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    final locations = ref.watch(locationSearchViewModel);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMarkers(locations);
    });
    return Stack(
      children: [
        NaverMap(
          options: NaverMapViewOptions(initialCameraPosition: NCameraPosition(target: NLatLng(37.5, 127.0), zoom: 12)),
          onMapReady: (controller) {
            setState(() {
              _mapController = controller;
              _updateMarkers(locations);
            });
          },
        ),
        Positioned(right: 10, bottom: MediaQuery.of(context).size.height / 2, child: NaverMapZoomControlWidget(mapController: _mapController)),
      ],
    );
  }
}
