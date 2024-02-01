
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/login.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
        child: ListView(
          children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Your App Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                leading: IconButton(onPressed: ()async{
                 await FirebaseAuth.instance.signOut();
                 // ignore: use_build_context_synchronously
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> const ScreenLogin()), (route) => false);
                },icon: const Icon(Icons.exit_to_app_outlined),),
              ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          
        }, icon: const Icon(Icons.menu_outlined),),
        centerTitle: true,
        title: Text(
          'Tech Shift',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search_sharp))
        ],
      ),

      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: [
                    Pics.promoBanner1,
                    Pics.promoBanner2,
                    Pics.promoBanner3,
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: 250,
                            // margin: EdgeInsets.symmetric(horizontal: 5.0),

                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image(
                                image: AssetImage(i),
                                fit: BoxFit.cover,
                              ),
                            ));
                      },
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.58,
              height: 60,
              color: Colors.amber,
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.elasticInOut,
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
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ));
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Categories',
              style: TextStyling.titleText,
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.99,
              height: 180,
              color: Colors.amber,
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    scrollDirection: Axis.horizontal),
                items: [
              Pics.keyBoard,
              Pics.headSets,
              Pics.processor,
              Pics.cabinet,
              Pics.chair,
              Pics.mouse,
                  
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width* 0.4,
                        height: 20,
                        color: Colors.white,
                        child: const Column(
                          children: [
                            Image(image: AssetImage('assets/Categories/keyboard.png')),
                            

                          ],
                        ),
                      );

                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
