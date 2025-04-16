import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("test"), Text("test"), Text("test")]),
              ),
            ),
          );
        },
      ),
    );
  }
}
