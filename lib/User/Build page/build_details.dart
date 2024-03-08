import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/processor.dart';
import 'package:prosample_1/User/utils/colors.dart';
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
      appBar: AppBar(),
      bottomNavigationBar:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.grey,
                        offset: Offset(2, 2))
                  ]),
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .07,
              child: Icon(Icons.info_outline, color: AppColors.appTheme),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ProcessorConfig()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.appTheme,
              ),
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .07,
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyling.subtitleWhite,
                ),
              ),
            ),
          )
        ],
      ),
    ),
      body: SafeArea(
        child: Column(
                children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.999,
          height: MediaQuery.of(context).size.height * 0.34,
          child: const Image(
              image: AssetImage('assets/Ads section/Gaming_Room2.jpeg'),
              fit: BoxFit.cover),
        )
                ],
              ),
      ),
    );
  }
}
