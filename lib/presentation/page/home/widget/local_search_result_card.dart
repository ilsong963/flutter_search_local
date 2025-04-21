import 'package:flutter/material.dart';
import 'package:flutter_search_local/data/model/location.dart';
import 'package:flutter_search_local/core/util/remove_tag.dart';

class LocalSearchResultCard extends StatelessWidget {
  final Location result;
  const LocalSearchResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            removeTag(result.title),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
          ),

          const SizedBox(height: 6),

          /// Category (icon + text)
          Row(
            children: [
              const Icon(Icons.label_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(result.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 10),

          /// Address
          Text(
            result.roadAddress.isNotEmpty ? result.roadAddress : result.address,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
