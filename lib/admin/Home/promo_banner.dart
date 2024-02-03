import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenPromo extends StatefulWidget {
  const ScreenPromo({super.key});

  @override
  State<ScreenPromo> createState() => _ScreenPromoState();
}

class _ScreenPromoState extends State<ScreenPromo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Image(image: AssetImage('assets/login/login_logo.png')),
            ),
            SizedBox(width: 10),
            Text('Add ADS',style: CustomText.apptitle,),
          ],
        ),),
    );
  }
}