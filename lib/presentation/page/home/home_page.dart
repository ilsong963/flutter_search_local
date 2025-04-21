import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/core/helper/geolocator_helper.dart';
import 'package:flutter_search_local/core/util/convert_vworld_to_naver_lat_lng.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';
import 'package:flutter_search_local/presentation/page/home/widget/local_search_result_card.dart';
import 'package:flutter_search_local/presentation/page/home/widget/location_marker_map.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final draggableController = DraggableScrollableController();
  void Function(NLatLng latLng)? moveMapCamera;

  @override
  Widget build(BuildContext context) {
    final searchLocalResultList = ref.watch(locationSearchViewModel);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) async {
                  await ref.read(locationSearchViewModel.notifier).searchLocationsByKeyword(value);
                  if (draggableController.size < 0.4) {
                    draggableController.animateTo(0.6, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );

                final position = await GeolocatorHelper.getPositon();
                if (position != null) {
                  await ref.read(locationSearchViewModel.notifier).searchLocationsByGeo(position.latitude, position.longitude);
                  draggableController.animateTo(0.6, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                }

                if (context.mounted) Navigator.pop(context);
              },
              icon: Icon(Icons.gps_fixed),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          LocationMarkerMap(
            onControllerInitialized: (controller) {
              setState(() {
                moveMapCamera = controller;
              });
            },
          ),
          DraggableScrollableSheet(
            controller: draggableController,
            initialChildSize: 0.05,
            minChildSize: 0.05,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5, offset: Offset(0, -5))],
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: ListView.builder(
                        padding: EdgeInsets.all(30),
                        controller: scrollController,
                        itemCount: searchLocalResultList?.length ?? 0,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final result = searchLocalResultList![index];
                          return GestureDetector(
                            onTap: () {
                              final latLng = convertVWorldToNaverLatLng(result.mapx, result.mapy);
                              if (moveMapCamera != null) {
                                moveMapCamera!(latLng);
                                draggableController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                              }
                            },
                            child: Padding(padding: EdgeInsets.all(5), child: LocalSearchResultCard(result: result)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
