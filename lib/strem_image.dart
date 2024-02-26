import 'dart:async';

import 'package:flutter/material.dart';

class StremImage extends StatefulWidget {
  const StremImage({Key? key}) : super(key: key);

  @override
  State<StremImage> createState() => _StremImageState();
}

class _StremImageState extends State<StremImage> {
  late StreamController<int> streamController;
  late StreamSubscription streamSubscription;
  //list of paths to image assets.
  List<String> images = ['assets/cat.jpg', 'assets/cat1.jpg', 'assets/cat2.jpg', 'assets/cat3.jpg',  'assets/cat5.jpg'];

  @override
  void initState() {
    super.initState();
    streamController = StreamController<int>.broadcast();
    printImages();// to start printing images.
  }
//pass through the list of image,each image has 2 second to display
  printImages() async {
    for (var i = 0; i < images.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      streamController.add(i);
    }
    await Future.delayed(const Duration(seconds: 2)); // wait 2 second
    streamController.close(); // Close 
  }

  @override
  void dispose() {
    streamController.close(); // Close the stream when the widget is disposed
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(// listen to the stream 
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');//to show error massege ih not recived
            } else if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
             
              return Image.asset(
                images[snapshot.data!],
                key: Key(images[snapshot.data!]),//key to refrech images
                width: 200,
                height: 200,
              );
            }
          },
        ),
      ),
    );
  }
}
