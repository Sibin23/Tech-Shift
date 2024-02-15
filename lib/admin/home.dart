import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prosample_1/admin/Home/admin_home.dart';
import 'package:prosample_1/admin/details/details.dart';
import 'package:prosample_1/admin/orders/orders_history.dart';
import 'package:prosample_1/admin/pc%20builds/prebuild.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List pages = [
    const AdminHomePage(),
    const ScreenOrdersList(),
    const ScreenPreBuild(),
    const ScreenDetails(),
  ];
  int _myindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.grey)),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GNav(
            color: const Color.fromARGB(255, 47, 47, 47),
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: const Color.fromARGB(255, 25, 143, 198),
            padding: const EdgeInsets.all(10),
            onTabChange: (value) {
              setState(() {
                _myindex = value;
              });
            },
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.list_rounded,
                text: 'Orders',
              ),
              GButton(
                icon: Icons.build_outlined,
                text: 'PC Build',
              ),
              GButton(
                icon: Icons.info,
                text: 'Info',
              )
            ],
          ),
        ),
      ),
      body: pages[_myindex],
    );
  }
}
