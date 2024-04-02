import 'package:flutter/material.dart';

class Promo2 extends StatelessWidget {
  const Promo2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset('assets/Ads section/Logitech.webp',fit: BoxFit.contain));
  }
}