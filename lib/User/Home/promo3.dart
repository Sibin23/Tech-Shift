import 'package:flutter/material.dart';

class Promo3 extends StatelessWidget {
  const Promo3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset('assets/Ads section/Promo2.png', fit: BoxFit.contain, filterQuality: FilterQuality.high));
  }
}

// assets/Ads section/Promo2.png