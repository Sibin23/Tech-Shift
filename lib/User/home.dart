import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prosample_1/User/Details/process.dart';
import 'package:prosample_1/User/Home_screen/home_page.dart';
import 'package:prosample_1/User/Pre%20Builds/pre_build_pc.dart';
import 'package:prosample_1/User/user%20profile/profile.dart';

class HomeInfo extends StatefulWidget {
  const HomeInfo({super.key});

  @override
  State<HomeInfo> createState() => _HomeInfo();
}

class _HomeInfo extends State<HomeInfo> {
  List pages = [
    const ScreenHome(),
    const UserProfile(),
    const ScreenPC(),
    const ScreenProcess(),
  ];
  int _myindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            tabBackgroundColor: Colors.purple,
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
                icon: Icons.person_sharp,
                text: 'Profile',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.info,
                text: 'Details',
              )
            ],
          ),
        ),
      ),
      body: pages[_myindex],
    );
  }
}
