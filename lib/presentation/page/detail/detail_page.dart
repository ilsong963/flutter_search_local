import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: InAppWebView(initialUrlRequest: URLRequest(url: WebUri(url))));
  }
}
