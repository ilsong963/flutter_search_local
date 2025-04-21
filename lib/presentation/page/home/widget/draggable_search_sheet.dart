import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_search_local/core/util/convert_vworld_to_naver_lat_lng.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/presentation/page/home/widget/local_search_result_card.dart';

class DraggableSearchSheet extends StatelessWidget {
  final DraggableScrollableController draggableController;
  final List<Location>? searchLocalResultList;
  final void Function(NLatLng latLng)? moveMapCamera;

  const DraggableSearchSheet({super.key, required this.draggableController, required this.searchLocalResultList, required this.moveMapCamera});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: draggableController,
      initialChildSize: 0.05,
      minChildSize: 0.05,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5, offset: Offset(0, -5))],
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              Positioned.fill(
                child: ListView.builder(
                  padding: const EdgeInsets.all(30),
                  controller: scrollController,
                  itemCount: searchLocalResultList?.length ?? 0,
                  physics: const ClampingScrollPhysics(),
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
                      child: Padding(padding: const EdgeInsets.all(5), child: LocalSearchResultCard(result: result)),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
