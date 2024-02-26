import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/Build%20page/build_page.dart';
import 'package:prosample_1/User/Pre%20Builds/Screen%20prebuild/prebuild.dart';
import 'package:prosample_1/User/Pre%20Builds/prebuild_screen.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/widget2.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                title: const Text('Signout'),
                leading: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ScreenLogin()),
                        (route) => false);
                  },
                  icon: const Icon(Icons.exit_to_app_outlined),
                ),
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
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp))
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.28,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
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
          const SizedBox(height: 20),
          Text(
            'Categories',
            style: TextStyling.titleText,
          ),
          Text('Products From These Category Oftern Buy',
              style: TextStyling.categoryText),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.24,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('admin').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String imageUrl = document['image'];
                        String categoryName = document['name'];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(2.0, 2.3),
                                  )
                                ]),
                            width: MediaQuery.of(context).size.width * 0.38,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.99,
                                    height: 120,
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                    )),
                                Text(categoryName,
                                    style: TextStyling.categoryText)
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
          const SizedBox(height: 20),
          Container(
            color: const Color.fromARGB(255, 190, 213, 198),
            width: MediaQuery.of(context).size.width,
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
                          width: MediaQuery.of(context).size.width * 0.47,
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
                          width: MediaQuery.of(context).size.width * 0.47,
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
                          width: MediaQuery.of(context).size.width * 0.47,
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
                          width: MediaQuery.of(context).size.width * 0.47,
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
                            Text('See All Deals', style: TextStyling.subtitle),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.appTheme,
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.81,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('Pre Build Pc', style: TextStyling.titleText),
                Text('Best in Class Brand Support ',
                    style: TextStyling.categoryText),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('prebuild')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        mainAxisExtent: 230),
                                itemCount: 4,
                                itemBuilder: (ctx, index) {
                                  DocumentSnapshot document =
                                      snapshot.data!.docs[index];
                                 
                                  String imageUrl = document['image'];
                                  String name = document['name'];
                                  String categoryName = document['categoryid'];
                                  String cabinet = document['case'];
                                  String oldPrice = document['oldprice'];
                                  String newPrice = document['newprice'];
                                  String processor = document['processor'];
                                  String board = document['motherboard'];
                                  String ram = document['ram'];
                                  String ssd = document['ssd'];
                                  String expstorage = document['expstorage'];
                                  String gpu = document['gpu'];
                                  String features = document['features'];
                                  String cooler = document['cooler'];
                                  String psu = document['psu'];
                                  String warranty = document['warranty'];
                                  Map<String, dynamic> prebuild = {
                                     'image': imageUrl,
                                    'categoryid': categoryName,
                                    'name': name,
                                    'oldprice': oldPrice,
                                    'newprice': newPrice,
                                    'processor': processor,
                                    'motherboard': board,
                                    'ram': ram,
                                    'ssd': ssd,
                                    'expstorage': expstorage,
                                    'gpu': gpu,
                                    'features': features,
                                    'cooler': cooler,
                                    'psu': psu,
                                    'case': cabinet,
                                    'warranty': warranty
                                  };
                                  return UiCustom.preBuildCard(context, () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => PreBuildInfo(
                                                  prebuild: prebuild,
                                                )));
                                  },
                                      imageUrl: imageUrl,
                                      categoryName: categoryName,
                                      oldPrice: oldPrice.replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => "${m[1]},"),
                                      newPrice: newPrice.replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => "${m[1]},"),
                                      cabinet: cabinet);
                                }),
                          );
                        } else {
                          const CircularProgressIndicator();
                        }
                        return const CircularProgressIndicator();
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const PreBuildSection()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('See All Deals', style: TextStyling.subtitle),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("CHOOSE YOUR PC PART'S!", style: TextStyling.titleText2),
                  Text('Build Your Dream PC', style: TextStyling.titleText),
                  const SizedBox(height: 20),
                  const Text(
                    "Here is the PC configurator of PC components and it is perfect tool for  you to choose one by one the parts of your computer and try different configurations and budgets. It’s use is to configure your dream pc in simple way and you can assemble a computer by parts completely to your liking. Get your basic,  gaming or professional desktop pc at the best price and for you. Can you ask for more? You can check the characteristics of the article and its availability by clicking on its name.",
                  ),
                  const SizedBox(height: 30),
                  UiHelper.customButton(context, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ScreenBuild()));
                  }, text: 'Build'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ]))));
  }
}
