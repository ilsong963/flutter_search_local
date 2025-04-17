import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/presentation/page/home/home_page_view_model.dart';
import 'package:flutter_search_local/presentation/page/home/widget/local_search_result_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchLocalResultList = ref.watch(locationSearchViewModel);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: (value) async {
            await ref.read(locationSearchViewModel.notifier).searchLocal(value);
          },
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: searchLocalResultList?.length ?? 0,

        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () async {},
              child: Card(child: Padding(padding: EdgeInsets.all(20), child: LocalSearchResultCard(result: searchLocalResultList![index]))),
            ),
          );
        },
      ),
    );
  }
}
