import 'package:flutter/material.dart';
class Loading_Screen extends StatelessWidget {
  String content;
  Loading_Screen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(content, style: TextStyle(fontSize: 30),),
          CircularProgressIndicator(),
        ],
      )
    ),
  );
  }
}
