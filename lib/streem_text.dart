import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamTest extends StatefulWidget {
  const StreamTest({super.key});

  @override
  State<StreamTest> createState() => _StreamTestState();
}

class _StreamTestState extends State<StreamTest> {
    final List<String> images = [
// ImageConstant.img1,
// ImageConstant.img1,
// ImageConstant.img1,
// ImageConstant.img1,
// ImageConstant.img1,
// ImageConstant.img1,
// ImageConstant.img1,
// ImageConstant.img1,
'assets/go.png',
'assets/go.png',
'assets/go.png',
'assets/go.png',
"assets/go.png",
  ];
  StreamController<int> streamController=StreamController.broadcast();
// Stream function to yield each image path with a delay
  Stream showImage() async* {
    for (String imagePath in images) {
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





// MaterialButton(
//                 color:red,
//                 onPressed: (){
//                   print("Listen is working");
//                   Stream stream = streamController.stream;
//                   streamSubscription = stream.listen((event){
//                     print("Listen to $event");
//                   });
//                   setState(() {});
//                 },
//                 child: const Text("Add"),
//                 ),
//                 MaterialButton(
//                   color:sun,
//                   onPressed: (){
//                     int number = Random().nextInt(100) +1;
//                     streamController.add(number);
//                     print("number Added ($number)");
//                   },
//                   child: const Text("Close stream"),
//                   ),
//                   MaterialButton(
//                   color:blue,
//                   onPressed: (){
//                     print("Close stream");
//                     streamSubscription.cancel();
//                   },
//                   child: const Text("cancel"),
//                   ),