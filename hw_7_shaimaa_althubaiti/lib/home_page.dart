import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hw_7_shaimaa_althubaiti/helper/colrs.dart';
import 'package:hw_7_shaimaa_althubaiti/helper/extintion.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  StreamController<String> streamControl = StreamController.broadcast();
  StreamController<String> streamControl2 = StreamController.broadcast();
  late Animation _arrowAnimation;
  // _containerSizeAnimation;
  late AnimationController _arrowAnimationController;
  // late AnimationController _containerAnimationController;

  List images = [
    "assets/horse.jpeg",
    "assets/horse1.jpeg",
    "assets/horse2.jpeg",
    "assets/horse3.jpeg",
    "assets/horse4.jpeg",
    "assets/horse5.jpeg",
    "assets/horse6.jpeg",
    "assets/horse7.jpeg",
    "assets/horse8.jpeg",
    "assets/horse9.jpeg",
    "assets/hourse.jpeg",
  ];
  List images2 = [
    "assets/im1.png",
    "assets/im2.png",
    "assets/im4.png",
    "assets/im5.png",
    "assets/im6.png",
    "assets/im7.png",
    "assets/im8.png",
    "assets/im9.png",
    "assets/im10.png",
    "assets/im11.png",
  ];
  changimage() async {
    for (var i = 0; i < 11; i++) {
      if (i == 9) {
        i = 0;
      }
      await Future.delayed(const Duration(seconds: 10));
      streamControl.add(images[i]);
    }
  }

  changtext() async {
    for (var i = 0; i < 10; i++) {
      if (i == 10) {
        i = 0;
      }
      await Future.delayed(const Duration(seconds: 10));
      streamControl2.add(images2[i]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changimage();
    changtext();
    // _containerAnimationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 5000));
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);
    // _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(
    //     CurvedAnimation(
    //         curve: Curves.ease, parent: _containerAnimationController));
    // _containerAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.getWidth();
    final height = context.getHeight() / 4;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: StreamBuilder(
                stream: streamControl.stream,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Dialog(
                          backgroundColor: Colors.black,
                          child: Text("there was an error"),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Image.asset(
                    snapshot.data!,
                    gaplessPlayback: true,
                    height: context.getHeight() / 3,
                    width: context.getWidth() * 0.90,
                  );
                })),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: StreamBuilder(
                stream: streamControl2.stream,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Dialog(
                          backgroundColor: Colors.black,
                          child: Text("there was an error"),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return AnimatedBuilder(
                      animation: _arrowAnimationController,
                      builder: (context, child) => Transform.rotate(
                            angle: _arrowAnimation.value,
                            child: Image.asset(
                              snapshot.data!,
                              gaplessPlayback: true,
                              height: context.getHeight() / 2.5,
                              width: context.getWidth() * 0.90,
                            ),
                          ));
                })),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(purple),
            ),
            child: const Text(
              'Start image Animation',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              _arrowAnimationController.isCompleted
                  ? _arrowAnimationController.reverse()
                  : _arrowAnimationController.forward();
            },
          )
        ],
      ),
    );
  }
}
