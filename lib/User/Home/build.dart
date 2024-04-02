import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20Page/build%20screen/build_details.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

import '../utils/text_decorations.dart';

class HomeBuild extends StatelessWidget {
  const HomeBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
                        Text("CHOOSE YOUR PC PART'S!",
                            style: TextStyling.titleText2),
                        Text('Build Your Dream PC',
                            style: TextStyling.titleText),
                        const SizedBox(height: 20),
                        const Text(
                          "Here is the PC configurator of PC components and it is perfect tool for  you to choose one by one the parts of your computer and try different configurations and budgets. It’s use is to configure your dream pc in simple way and you can assemble a computer by parts completely to your liking. Get your basic,  gaming or professional desktop pc at the best price and for you. Can you ask for more? You can check the characteristics of the article and its availability by clicking on its name.",
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