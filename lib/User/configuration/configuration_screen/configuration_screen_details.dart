import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/configuration_screen/configuration_screen_bottomnav.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenBuild extends StatefulWidget {
  const ScreenBuild({super.key});

  @override
  State<ScreenBuild> createState() => _ScreenBuildState();
}

class _ScreenBuildState extends State<ScreenBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white),
      bottomNavigationBar: const BuildDetailBottom(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.999,
              height: MediaQuery.of(context).size.height * 0.34,
              child: const Image(
                  image: AssetImage('assets/ads/Gaming_Room2.jpeg'),
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
                      "The PC Configurator from Pc Components is the perfect tool to build your dream PC. Choose individual components, experiment with different configurations, and stay within your budget. It's a simple and intuitive process that lets you customize your desktop PC, whether you need a basic setup, a powerful gaming rig, or a professional workstation. Why settle for anything less? Click the \"Details\" button to learn more.",
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
