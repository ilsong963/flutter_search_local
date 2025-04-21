import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/core/helper/geolocator_helper.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final DraggableScrollableController draggableController;

  const CustomAppBar({super.key, required this.draggableController});

  @override
  Size get preferredSize => const Size.fromHeight(70); // AppBar 높이 지정

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 4,
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (value) async {
                    if (value.trim().isEmpty) return;

                    await ref.read(locationSearchViewModel.notifier).searchLocationsByKeyword(value);
                    if (draggableController.size < 0.4) {
                      draggableController.animateTo(0.6, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "검색어를 입력하세요",
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () async {
                  showDialog(context: context, barrierDismissible: false, builder: (context) => const Center(child: CircularProgressIndicator()));

                  final position = await GeolocatorHelper.getPositon();
                  if (position != null) {
                    await ref.read(locationSearchViewModel.notifier).searchLocationsByGeo(position.latitude, position.longitude);
                    draggableController.animateTo(0.6, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }

                  if (context.mounted) Navigator.pop(context);
                },
                icon: const Icon(Icons.gps_fixed),
                tooltip: "현위치 검색",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
