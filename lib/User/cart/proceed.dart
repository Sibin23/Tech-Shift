import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ProceedButton extends StatefulWidget {
  const ProceedButton({super.key});

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: AppColors.appTheme),
      height: MediaQuery.of(context).size.height * .07,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Center(
          child: Text(
        'Proceed',
        style: TextStyling.subtitleWhite,
      )),
    );
  }
}
