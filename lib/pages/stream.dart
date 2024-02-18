import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({Key? key}) : super(key: key);

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  StreamController<int> streamController = StreamController.broadcast();

  late StreamSubscription streamSubscription;
  late int currentImageIndex;
  List<String> images = [
    "assets/images/image0.jpeg",
    "assets/images/image1.jpeg",
    "assets/images/image2.jpeg",
    "assets/images/image3.jpeg",
    "assets/images/image4.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    streamImages();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  streamImages() {
    currentImageIndex = 0;
    Timer.periodic(Duration(seconds: 10), (timer) {
      streamController.add(currentImageIndex);
      if (currentImageIndex < images.length - 1) {
        currentImageIndex = (currentImageIndex + 1);
      } else {
        currentImageIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Bootcamp"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int index = snapshot.data!;
                  return Image.asset(
                    images[index],
                    width: 350,
                    height: 350,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color(0xff5694CB),
              onPressed: () {
                print("Close stream");
                streamController.close();
              },
              child: Text("Cancel"),
            )
          ],
        ),
      ),
    );
  }
}
