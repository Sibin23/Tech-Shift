import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/Build%20page/build_page.dart';
import 'package:prosample_1/login.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

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
      drawer: Drawer(
        child: ListView(
          children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Your App Name',
                style: TextStyling.titleText2,
              ),
            ),
            ListTile(
              title: const Text('Signout'),
              leading: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
                      (route) => false);
                },
                icon: const Icon(Icons.exit_to_app_outlined),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
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
              const SizedBox(width: 10),
            Text(
              'Tech Shift',
              style: TextStyling.titleText,
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp))
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
              color: Colors.purple,
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
            const SizedBox(height: 20),
            Text(
              'Categories',
              style: TextStyling.titleText,
            ),
            const SizedBox(height: 20),
            SizedBox(
              
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: Pics.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: SizedBox(
                      width: 130,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: Image(
                                    image: AssetImage(Pics.categories[index])),
                              ),
                              Text(Pics.categoriesName[index]),
                            ]),
                      ),
                    ),
                  );
                },
                physics: const BouncingScrollPhysics(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: const Color.fromARGB(255, 190, 213, 198),
              width: MediaQuery.of(context).size.width * 0.999,
              height: MediaQuery.of(context).size.height * 0.875,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "This Weeks Special's",
                        style: TextStyling.titleText,
                      ),
                      const Text(
                          'All our New Arrivals in an exclusive brand selection'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Processors/Intel Core i9 14900KF.png',
                                category: 'Intel Processor',
                                subtitle:
                                    'Intel Core i9 14700k Desktop Processor',
                                oldamt: '84,999',
                                currentamt: '54,469'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Processors/Intel Core i9 14900KF.png',
                                category: 'Intel Processor',
                                subtitle:
                                    'Intel Core i9 14700k Desktop Processor',
                                oldamt: '84,999',
                                currentamt: '54,469'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Processors/Intel Core i9 14900KF.png',
                                category: 'Intel Processor',
                                subtitle:
                                    'Intel Core i9 14700k Desktop Processor',
                                oldamt: '84,999',
                                currentamt: '54,469'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Processors/Intel Core i9 14900KF.png',
                                category: 'Intel Processor',
                                subtitle:
                                    'Intel Core i9 14700k Desktop Processor',
                                oldamt: '84,999',
                                currentamt: '54,469'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('See All Deals',
                                  style: TextStyling.subtitle),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.purple,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              color: const Color.fromARGB(255, 224, 208, 226),
              width: MediaQuery.of(context).size.width * 0.999,
              height: MediaQuery.of(context).size.height * 0.875,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Special offers for you",
                        style: TextStyling.titleText,
                      ),
                      const Text('Pre-Build PC'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Cabinet/Ant Esports  SX7 Mid Tower White.png',
                                category: 'BRANDED PC BUDGET SERIES',
                                subtitle: 'Ant Esports ICE-300 MESH V2',
                                oldamt: '39,599',
                                currentamt: '36,589'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Cabinet/gallery-nx292-01-removebg-preview.png',
                                category: 'BRANDED PC BUDGET SERIES',
                                subtitle: 'Ant Esports ICE-300 MESH V2',
                                oldamt: '39,599',
                                currentamt: '36,589'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Cabinet/MSI MAG Forge M100 A Micro.png',
                                category: 'BRANDED PC BUDGET SERIES',
                                subtitle: 'Ant Esports ICE-300 MESH V2',
                                oldamt: '39,599',
                                currentamt: '36,589'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.478,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: UiHelper.itemCard(
                                image:
                                    'assets/Cabinet/GALAX Revolution 06 white.png',
                                category: 'BRANDED PC BUDGET SERIES',
                                subtitle: 'Ant Esports ICE-300 MESH V2',
                                oldamt: '39,599',
                                currentamt: '36,589'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('See All Deals',
                                  style: TextStyling.subtitle),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.purple,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.999,
              height: MediaQuery.of(context).size.height * 0.34,
              child: const Image(
                image: AssetImage('assets/Ads section/Gaming room.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text("CHOOSE YOUR PC PART'S!", style: TextStyling.titleText2),
            Text('Build Your Dream PC', style: TextStyling.titleText),
            const Padding(
              padding: EdgeInsets.all(13.0),
              child: Text(
                "Here is the PC configurator of PC components and it is perfect tool for  you to choose one by one the parts of your computer and try different configurations and budgets. It’s use is to configure your dream pc in simple way and you can assemble a computer by parts completely to your liking. Get your basic,  gaming or professional desktop pc at the best price and for you. Can you ask for more? You can check the characteristics of the article and its availability by clicking on its name.",
              ),
            ),
            UiHelper.customButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const ScreenBuild()));
            }, 'Build',Icons.laptop_windows_rounded),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
