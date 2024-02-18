import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hw7_alaa/constant/color.dart';
import 'package:hw7_alaa/constant/spaces.dart';

class HomeStream extends StatefulWidget {
  const HomeStream({super.key});

  @override
  State<HomeStream> createState() => _HomeStreamState();
}

class _HomeStreamState extends State<HomeStream> {
  StreamController streamController = StreamController.broadcast();
  StreamController streamController1 = StreamController.broadcast();
  late StreamSubscription streamSubscription;

  List<String> images = [
    "asset/hw7-image1.jpg",
    "asset/hw7-image2.jpg",
    "asset/hw7-image3.jpg",
    "asset/hw7-image4.jpg",
    "asset/hw7-image5.jpg",
    "asset/hw7-image6.jpg",
    "asset/hw7-image7.jpg",
    "asset/hw7-image8.jpg",
    "asset/hw7-image9.jpg",
    "asset/hw7-image10.jpg",
    "asset/hw7-image11.jpg",
    "asset/hw7-image12.jpg",
  ];

  Stream imageStream() async* {
    for (var imageIndex = 0; imageIndex < images.length; imageIndex++) {
      await Future.delayed(const Duration(seconds: 10));

      yield images[imageIndex];      
    }
  }

  numberStream() async {
    for (int i = 1; i <= images.length; i++) {
      await Future.delayed(const Duration(seconds: 10));
      streamController1.add(i);
    }
  }

  @override
  void initState() {
    super.initState();
    numberStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          width100,
          Center(
            child: StreamBuilder(
              stream: imageStream(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(
                      "Error ${snapshot.error}"); // LinearProgressIndicator();
                }
                return Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width * .75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkBrown,
                    boxShadow: const [
                      BoxShadow(
                        color: darkBrown,
                        blurRadius: 24.0,
                        spreadRadius: 10.0,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      snapshot.data,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                );
              }),
            ),
          ),
          height24,
          const Text(
            "مسابقة يوم التأسيس 2024-2-22",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: darkBrown),
          ),
          height12,
          StreamBuilder(
            stream: streamController1.stream,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(
                    "Error ${snapshot.error}"); // LinearProgressIndicator();
              }
              return Container(
                height: 40,
                width: 230,
                decoration: const BoxDecoration(
                  color: darkBrown,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Number of image \" ${snapshot.data.toString()} \"",
                    style: const TextStyle(color: white, fontSize: 18),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      // ),
    );
  }
}
