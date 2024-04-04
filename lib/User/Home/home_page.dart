import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/Home/build.dart';
import 'package:prosample_1/User/Home/categories.dart';
import 'package:prosample_1/User/Home/prebuid_pc.dart';
import 'package:prosample_1/User/Home/promo1.dart';
import 'package:prosample_1/User/Home/promo2.dart';
import 'package:prosample_1/User/Home/promo3.dart';
import 'package:prosample_1/User/Profile/profile_contact_page.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/login.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  CarouselController buttonCarouselController = CarouselController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void signOut() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Tech Shift',
                  style: TextStyling.titleText2,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/Icons/contact_us.png',
                  width: 30,
                  height: 30,
                ),
                title: Text('Contact Us', style: TextStyling.subtitle2),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const ScreenContact()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(Icons.menu_outlined),
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  width: 40,
                  height: 40,
                  image: AssetImage('assets/login/login_logo.png')),
              const SizedBox(width: 5),
              Text(
                'Tech Shift',
                style: TextStyling.appTitle,
              ),
            ],
          ),
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp))
          // ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 900),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                aspectRatio: 16 / 9,
              ),
              items: const [Promo1(), Promo2(), Promo3()],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.58,
            height: 60,
            color: Colors.purple.shade800,
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.elasticInOut,
                  reverse: true,
                  scrollDirection: Axis.vertical),
              items: [
                Pics.promoText1,
                Pics.promoText2,
                Pics.promoText3,
                Pics.promoText4
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                        child: Center(
                      child: Text(
                        i,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ));
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const HomeCategories(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const HomePreBuildPC(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const HomeBuild(),
          )
        ]))));
  }
}
