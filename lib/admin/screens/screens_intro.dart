import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

class ScreenIntro extends StatelessWidget {
  const ScreenIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *.1,
      width: MediaQuery.of(context).size.width,
      child: Text('Hi, Welcome Admin', style: CustomText.title));
  }
}