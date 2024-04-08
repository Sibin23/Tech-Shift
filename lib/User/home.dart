import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prosample_1/User/favorites/favourites.dart';
import 'package:prosample_1/User/user_home/user_home_main.dart';
import 'package:prosample_1/User/profile/profile_main.dart';
import 'package:prosample_1/User/cart/cart_main.dart';
import 'package:prosample_1/login.dart';

class HomeInfo extends StatefulWidget {
  final int? initialIndex;
  const HomeInfo({super.key, this.initialIndex});

  @override
  State<HomeInfo> createState() => _HomeInfo();
}

class _HomeInfo extends State<HomeInfo> {
  _checkLoginStatus() {
    final Stream<User?> authStateChanges =
        FirebaseAuth.instance.authStateChanges();
    StreamBuilder<User?>(
      stream: authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeInfo();
        } else {
          return const ScreenLogin();
        }
      },
    );
  }

  List pages = [
    const ScreenHome(),
    const Profile(),
    const ScreenCart(),
    const ScreenFavorites(),
  ];
  int myindex = 0;

  @override
  void initState() {
    _checkLoginStatus();
    myindex = myindex;
    super.initState();
  }

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
            tabBackgroundColor: Colors.purple.shade800,
            padding: const EdgeInsets.all(10),
            onTabChange: (value) {
              setState(() {
                myindex = value;
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
                icon: Icons.favorite,
                text: 'Favorites',
              )
            ],
          ),
        ),
      ),
      body: pages[myindex],
    );
  }
}
