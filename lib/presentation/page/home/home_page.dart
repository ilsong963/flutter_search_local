import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/core/helper/geolocator_helper.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';
import 'package:flutter_search_local/presentation/page/home/widget/local_search_result_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchLocalResultList = ref.watch(locationSearchViewModel);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) async {
                  await ref.read(locationSearchViewModel.notifier).searchLocationsByKeyword(value);
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),

            IconButton(
              onPressed: () async {
                final position = await GeolocatorHelper.getPositon();
                if (position != null) {
                  await ref.read(locationSearchViewModel.notifier).searchLocationsByGeo(position.latitude, position.longitude);
                }
              },
              icon: Icon(Icons.gps_fixed),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          DraggableScrollableSheet(
            initialChildSize: 0.05, // 초기 높이를 5%로 설정
            minChildSize: 0.05, // 최소 높이를 5%로 설정
            maxChildSize: 0.8, // 최대 높이를 80%로 설정
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(0, -5), // 그림자의 위치 조정
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // 손잡이 역할을 하는 위젯
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
                          return Padding(padding: EdgeInsets.all(5), child: LocalSearchResultCard(result: searchLocalResultList![index]));
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
