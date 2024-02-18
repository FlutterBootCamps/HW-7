import 'dart:async';

import 'package:flutter/material.dart';

class streamhw extends StatefulWidget {
  @override
  _Streamhw createState() => _Streamhw();
}

class _Streamhw extends State<streamhw> {
  int _refreshCount = 0;
  late StreamController<int> _refreshStreamController;
  List<String> _imagePaths = ['images/logo.png', 'images/book.png'];
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _refreshStreamController = StreamController<int>();
    _refreshStreamController.stream.listen((_) {
      setState(() {
        _refreshCount++;
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });

    Timer.periodic(Duration(seconds: 10), (timer) {
      _refreshStreamController.add(_refreshCount);
    });
  }

  @override
  void dispose() {
    _refreshStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Every 10 seconds the image will change'),
            SizedBox(height: 20),
            Image.asset(
              _imagePaths[_currentImageIndex],
              width: 300,
              height: 300,
              fit: BoxFit.cover,
              
            ),
            
          ],
        ),
      ),
    );
  }
}
