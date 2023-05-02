import 'package:app2/pfe/page1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext Context) {
    return MaterialApp(
      //appel la class homepage
      home: page1(),
    );
  }
}
