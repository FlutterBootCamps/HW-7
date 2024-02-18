import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hw_7/component/image_card.dart';
import 'package:hw_7/data/data.dart';


class strems extends StatefulWidget {
  strems({super.key});

  @override
  State<strems> createState() => _stremsState();
}

class _stremsState extends State<strems> {
 

  imageShower() async {
    int i = 0;
    do {
      stremC.add(i);
      await Future.delayed(Duration(seconds: 10));
      i++;
      print(i);
    } while (i < listImages.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageShower();
  }

  StreamController stremC = StreamController.broadcast();

  late StreamSubscription streamSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
            backgroundColor: Colors.cyan.shade600,
            title: const Text(
              "my projects in flutter",
              strutStyle: StrutStyle(fontSize: 30, fontWeight: FontWeight.w600),
            )),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          StreamBuilder(
            stream: stremC.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              String name = "";
              if (snapshot.data < 5)
                name = "Kindergarten app first project";
              else if (snapshot.data < 9)
                name = "task manger v2 second project";
              else if (snapshot.data < 12)
                name = "informaiton insert third project";
              else if (snapshot.data < 16) name = "planitfy fourth project";

              return imageCard(
                  ImagePath: listImages[snapshot.data], name: name);
            },
          )
        ]));
  }
}

