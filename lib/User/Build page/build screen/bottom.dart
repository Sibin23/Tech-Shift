import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/build%20screen/process.dart';
import 'package:prosample_1/User/Build%20page/processor.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class BuildDetailBottom extends StatefulWidget {
  const BuildDetailBottom({super.key});

  @override
  State<BuildDetailBottom> createState() => _BuildDetailBottomState();
}

class _BuildDetailBottomState extends State<BuildDetailBottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ProcessDetails()));
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: AppColors.appTheme),
                  const SizedBox(width: 5),
                  Text('Details',style: TextStyling.subtitleapptheme)
                ],
              ),
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
    );
  }
}