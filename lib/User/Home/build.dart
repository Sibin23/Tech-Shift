import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20Page/build%20screen/build_details.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

import '../utils/text_decorations.dart';

class HomeBuild extends StatelessWidget {
  const HomeBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.999,
            height: MediaQuery.of(context).size.height * 0.34,
            child: const Image(
              image: AssetImage('assets/Ads section/Gaming room.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("CHOOSE YOUR PC PART'S!", style: TextStyling.titleText2),
                  Text('Build Your Dream PC', style: TextStyling.titleText),
                  const SizedBox(height: 20),
                  const Text(
                    "Ready to build your dream PC?  Our PC configurator lets you choose individual components, experiment with different configurations, and stay within your budget. It's simple and intuitive!  Click \"Build\" to start customizing your perfect PC, whether it's for basic tasks, high-performance gaming, or professional work. Why wait?  Click and unleash your PC building potential!",
                  ),
                  const SizedBox(height: 30),
                  UiHelper.customButton(context, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ScreenBuild()));
                  }, text: 'Build'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
