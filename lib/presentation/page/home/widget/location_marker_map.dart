import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/core/util/convert_vworld_to_naver_lat_lng.dart';
import 'package:flutter_search_local/core/util/remove_tag.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/presentation/page/detail/detail_page.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';

class LocationMarkerMap extends ConsumerStatefulWidget {
  final void Function(void Function(NLatLng latLng))? onControllerInitialized;

  const LocationMarkerMap({super.key, this.onControllerInitialized});

  @override
  LocationMarkerMapState createState() => LocationMarkerMapState();
}

class LocationMarkerMapState extends ConsumerState<LocationMarkerMap> {
  NaverMapController? _mapController;

  void _moveCameraTo(NLatLng latLng) {
    _mapController?.updateCamera(NCameraUpdate.withParams(target: latLng, zoom: 15));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onControllerInitialized?.call(_moveCameraTo);
    });
  }

  Set<NMarker> _buildMarkers(List<Location>? locations) {
    if (locations == null || locations.isEmpty) {
      return <NMarker>{};
    }

    return locations.map((location) {
      final marker = NMarker(
        id: 'marker_${removeTag(location.title)}',
        position: convertVWorldToNaverLatLng(location.mapx, location.mapy),
        caption: NOverlayCaption(text: removeTag(location.title)),
      );

      _mapController!.addOverlay(marker);

      if (location.link.startsWith("https")) {
        final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: "링크");
        marker.openInfoWindow(onMarkerInfoWindow);
        marker.setOnTapListener((NMarker tappedMarker) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(url: location.link)));
        });
      }

      return marker;
    }).toSet();
  }

  void _updateMarkers(List<Location>? locations) {
    if (_mapController == null) return;

    // 기존 마커 제거
    _mapController!.clearOverlays();

    // 새로운 마커 추가
    _buildMarkers(locations);
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
