import 'package:flutter/material.dart';
import 'package:prosample_1/User/cart/configure_cart.dart';
import 'package:prosample_1/User/cart/others.dart';
import 'package:prosample_1/User/cart/prebuild_cart.dart';
import 'package:prosample_1/User/cart/proceed.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  bool showAppBar = true; // Assume AppBar is initially visible

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: ProceedButton(),
            )),
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cart Page'),
              SizedBox(width: 5),
              Icon(Icons.shopping_cart_outlined)
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const PreBuildCart(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const ConfigureCart(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const OthersCart(),
                ),
              ],
            ),
          ),
        ));
  }
}
