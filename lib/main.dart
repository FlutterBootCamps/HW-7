import 'package:flutter/material.dart';
import 'package:hw_7/strem.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: strems()
    );
  }
}
