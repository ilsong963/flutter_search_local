import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';
import 'package:flutter_search_local/presentation/page/home/widget/appbar.dart';
import 'package:flutter_search_local/presentation/page/home/widget/draggable_search_sheet.dart';
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
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(draggableController: draggableController),
      body: Stack(
        children: [
          LocationMarkerMap(
            onControllerInitialized: (controller) {
              setState(() {
                moveMapCamera = controller;
              });
            },
          ),
          DraggableSearchSheet(draggableController: draggableController, searchLocalResultList: searchLocalResultList, moveMapCamera: moveMapCamera),
        ],
      ),
    );
  }
}
