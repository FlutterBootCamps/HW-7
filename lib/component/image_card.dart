import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class imageCard extends StatelessWidget {
  const imageCard({
    super.key,
    required this.name,
    required this.ImagePath,
  });
  final String name;
  final String ImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey.shade500,
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 4, spreadRadius: 10, blurStyle: BlurStyle.solid)
          ],
          color: Colors.cyan),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
                text: "name of the project : \n",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: "$name",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ))
                ]),
          ),
          Image.asset(
            ImagePath,
            height: 500,
            width: 400,
          )
        ],
      ),
    );
  }
}
