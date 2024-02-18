import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController streamController = StreamController.broadcast();
  late StreamSubscription streamSubscription;

  displayimage() async {
    for (var i = 1; i <= 7; i++) {
      await Future.delayed(const Duration(milliseconds: 10000));
      streamController.add(i);
    }
  }

  Stream streamimage() async* {
    for (var i = 1; i <= 7; i++) {
      await Future.delayed(const Duration(milliseconds: 10000));
      yield i;
    }
  }

  @override
  void initState() {
    super.initState();
    displayimage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Stream images",
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: streamimage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('error');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                        child: Column(
                      children: [
                        Image.asset(
                          "images/image${snapshot.data}.jpg",
                          fit: BoxFit.contain,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            "${snapshot.data}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
