import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/core/helper/geolocator_helper.dart';
import 'package:flutter_search_local/presentation/page/detail/detail_page.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';
import 'package:flutter_search_local/presentation/page/home/widget/local_search_result_card.dart';
import 'package:flutter_search_local/presentation/page/home/widget/location_marker_map.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchLocalResultList = ref.watch(locationSearchViewModel);

    // 1. Controller 선언
    final draggableController = DraggableScrollableController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) async {
                  await ref.read(locationSearchViewModel.notifier).searchLocationsByKeyword(value);

                  // 3. 검색 후 드로어 펼치기
                  if (draggableController.size < 0.4) {
                    draggableController.animateTo(2.0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            IconButton(
              onPressed: () async {
                final position = await GeolocatorHelper.getPositon();
                if (position != null) {
                  await ref.read(locationSearchViewModel.notifier).searchLocationsByGeo(position.latitude, position.longitude);
                  draggableController.animateTo(0.6, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                }
              },
              icon: Icon(Icons.gps_fixed),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          LocationMarkerMap(),
          DraggableScrollableSheet(
            controller: draggableController, // 2. 연결
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
                              // if (result.link.startsWith("https")) {
                              //   Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(url: result.link)));
                              // }
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
