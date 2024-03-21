import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/build%20screen/bottom.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ScreenBuild extends StatefulWidget {
  const ScreenBuild({super.key});

  @override
  State<ScreenBuild> createState() => _ScreenBuildState();
}

class _ScreenBuildState extends State<ScreenBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> const HomeInfo()), (route) => false);
              }),
          surfaceTintColor: Colors.white),
      bottomNavigationBar: const BuildDetailBottom(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.999,
              height: MediaQuery.of(context).size.height * 0.34,
              child: const Image(
                  image: AssetImage('assets/Ads section/Gaming_Room2.jpeg'),
                  fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Select the components to configure.',
                    style: TextStyling.appTitle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                      'The PC configurator of Pc Components is the perfect tool for you to choose one by one the parts of your computer and try different configurations and budgets. Its use is very simple and intuitive, and in a few steps you can assemble a computer by parts completely to your liking. Get your basic, gaming or professional desktop pc at the best price and for you. Can you ask for more? You can check the characteristics of the article and its availability by clicking on its name.',
                      style: TextStyling.subtitle2)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
