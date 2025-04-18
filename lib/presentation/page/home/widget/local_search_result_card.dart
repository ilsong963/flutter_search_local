import 'package:flutter/material.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/core/util/remove_tag.dart';

class LocalSearchResultCard extends StatelessWidget {
  final Item result;
  const LocalSearchResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(removeTag(result.title)), Text(result.category), Text(result.roadAddress.isEmpty ? result.address : result.roadAddress)],
        ),
      ),
    );
  }
}
