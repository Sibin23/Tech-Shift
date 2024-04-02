import 'package:flutter/material.dart';
import 'package:prosample_1/User/home.dart';

class CartLoading extends StatefulWidget {
  const CartLoading({super.key});

  @override
  State<CartLoading> createState() => _CartLoadingState();
}

class _CartLoadingState extends State<CartLoading> {
  @override
  void initState() {
    loading();
    super.initState();
  }

  Future<void> loading() async {
    Future.delayed(const Duration(seconds: 2));
    toHome();
  }

  toHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const HomeInfo()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
         
        ],
      ),
    );
  }
}
