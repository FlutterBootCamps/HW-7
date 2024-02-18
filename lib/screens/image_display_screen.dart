import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class ImageDisplayScreen extends StatefulWidget {
  ImageDisplayScreen({super.key});

  List<String> imagePaths = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg",
    "assets/images/image4.jpg",
    "assets/images/image5.jpg",
    "assets/images/image6.jpg",
    "assets/images/image7.jpg",
    "assets/images/image8.jpg",
    "assets/images/image9.jpg",
    "assets/images/image10.jpg",
  ];
  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  StreamController<String> streamController = StreamController();
  late StreamSubscription streamSubscription;

  void setupAudioPlayer() async {
    final player = AudioPlayer();
    player.setAsset("assets/audio/song.mp3");
    player.play();
  }

  void getImages() async {
    for (var element in widget.imagePaths) {
      await Future.delayed(const Duration(seconds: 10));
      streamController.add(element);
    }
  }

  @override
  void initState() {
    super.initState();
    setupAudioPlayer();
    streamController.add("assets/images/BFF_logo.png");
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(snapshot.data!),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(80)),
              ),
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .5,
            );
          },
        ),
      ),
    );
  }
}

// Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(image: AssetImage(""))
//           ),
//           width: MediaQuery.of(context).size.width * .8,
//           height: MediaQuery.of(context).size.height * .5,
//         ),