import 'dart:async';

import 'package:flutter/material.dart';

class MyStream extends StatefulWidget {
  const MyStream({Key? key}) : super(key: key);

  @override
  State<MyStream> createState() => _MyStreamState();
}

class _MyStreamState extends State<MyStream> {
  // Create a stream controller to handle the stream of images
  // StreamController controller = StreamController.broadcast();
  // late StreamSubscription _streamSubscription;

  // List of image paths
  List<String> myImage = [
    "image/image1.jpg",
    "image/image2.jpg",
    "image/image3.jpg",
    "image/image4.jpg",
    "image/image5.jpg",
    "image/image6.jpg",
    "image/image7.jpg",
    "image/image8.jpg",
    "image/image9.jpg",
    "image/image10.jpg",
  ];

  // Stream function to yield each image path with a delay
  Stream showImage() async* {
    for (String imagePath in myImage) {
      yield imagePath;
      await Future.delayed(Duration(seconds: 10)); // Adjust delay as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Image"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: StreamBuilder(
          stream: showImage(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if there's an error with the stream
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the image using Image.asset
              return Image.asset(snapshot.data.toString());
            }
          },
        ),
      ),
    );
  }
}