import 'package:flutter/material.dart';

class ScreenBuild extends StatefulWidget {
  const ScreenBuild({super.key});

  @override
  State<ScreenBuild> createState() => _ScreenBuildState();
}

class _ScreenBuildState extends State<ScreenBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.999,
            height: MediaQuery.of(context).size.height * 0.34,
            child: const Image(image: AssetImage('assets/Ads section/Gaming_Room2.jpeg'),fit: BoxFit.cover,),
          )
        ],
      ),
    ),);
  }
}