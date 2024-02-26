import 'package:flutter/material.dart';
import 'package:hw7/strem_image.dart';


void main(List<String> args) {
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StremImage(),
    );
  }
}