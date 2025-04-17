import 'package:flutter/material.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/presentation/page/detail/detail_page.dart';
import 'package:flutter_search_local/core/util/remove_tag.dart';

class LocalSearchResultCard extends StatelessWidget {
  final Item result;
  const LocalSearchResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (result.link.startsWith("https")) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(url: result.link)));
        }
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(removeTag(result.title)), Text(result.category), Text(result.roadAddress.isEmpty ? result.address : result.roadAddress)],
          ),
        ),
      ),
    );
  }
}
