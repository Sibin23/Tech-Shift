import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/user_home/user_home_build_section.dart';
import 'package:prosample_1/User/user_home/user_home_categories_section.dart';
import 'package:prosample_1/User/user_home/user_home_newarivals.dart';
import 'package:prosample_1/User/user_home/user_home_popular.dart';
import 'package:prosample_1/User/user_home/user_home_prebuid_section.dart';
import 'package:prosample_1/User/user_home/user_home_promo1.dart';
import 'package:prosample_1/User/user_home/user_home_promo2.dart';
import 'package:prosample_1/User/user_home/user_home_promo3.dart';
import 'package:prosample_1/User/user_home/user_home_contact_page.dart';
import 'package:prosample_1/User/user_home/user_home_terms_policies.dart';
import 'package:prosample_1/User/user_home/user_home_warranty_policy.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
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
          surfaceTintColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/login/login_logo.png',
                            filterQuality: FilterQuality.high)),
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Tech Shift',
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 25)),
                        Text('Tech Store', style: TextStyling.subtitleWhite)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: Image.asset(
                  'assets/icons/terms&conditions.png',
                  width: 30,
                  height: 30,
                ),
                title: Text('Terms & Policies', style: TextStyling.subtitle2),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const TermsAndPolicy()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/warranty.png',
                  width: 30,
                  height: 30,
                ),
                title: Text('Warranty Policy', style: TextStyling.subtitle2),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const WarrantyPolicy()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/contact_us.png',
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
            child: const HomePopularItems(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const HomeNewArrivals(),
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
