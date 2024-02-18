import 'dart:async';

import 'package:flutter/material.dart';

class ImagesDisplay extends StatefulWidget {
  const ImagesDisplay({Key? key}) : super(key: key);

  @override
  State<ImagesDisplay> createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesDisplay> {
    // Creating a StreamController to manage the stream 
  StreamController streamController = StreamController.broadcast();

  late StreamSubscription streamSubscription;
  late int currentImageIndex;

  List<String> images = [
    "images/A.jpg",
    "images/B.jpg",
    "images/C.jpg",
  ];

  @override
  void initState() {
    super.initState();
    currentImageIndex = 0;
    // Call the function to start changing images.
    changeImageEveryTenSeconds();
  }
 // Function to change the image every ten seconds.
  changeImageEveryTenSeconds() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % images.length;
      });
    }
  }

  @override
  void dispose() {
    // Close the stream when the widget is disposed.
    streamController.close(); 
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  var appBarHeight = AppBar().preferredSize.height;
  var statusBarHeight = MediaQuery.of(context).padding.top;

  return Scaffold(
    appBar: AppBar(
      title: const Text('Images Display',
      style: TextStyle(
        fontWeight: (FontWeight.bold),
        color: Colors.white
      ),
      
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      actions: const [Icon(Icons.access_time_rounded)],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              images[currentImageIndex],
              width: screenWidth,
              height: screenHeight - appBarHeight - statusBarHeight,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );
}
}