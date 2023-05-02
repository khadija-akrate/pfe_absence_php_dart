
import 'package:flutter/material.dart';

class modifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier"),
      ),
      drawer: Drawer(),
      body: Text("hi"),
    );
  }
}
