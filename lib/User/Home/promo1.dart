import 'package:flutter/material.dart';

class Promo1 extends StatelessWidget {
  const Promo1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset('assets/Ads section/promo1.png', fit: BoxFit.contain,filterQuality: FilterQuality.high));
  }
}
