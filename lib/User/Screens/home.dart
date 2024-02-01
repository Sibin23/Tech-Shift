// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prosample_1/User/Home_screen/commonfile.dart';

// class ScreenHome extends StatefulWidget {
//   const ScreenHome({super.key});

//   @override
//   State<ScreenHome> createState() => _ScreenHomeState();
// }

// class _ScreenHomeState extends State<ScreenHome> {
//   CarouselController buttonCarouselController = CarouselController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Tech Shift',
//           style: GoogleFonts.poppins(),
//         ),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 200,
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     viewportFraction: 0.8,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     autoPlayInterval: const Duration(seconds: 2),
//                     autoPlayAnimationDuration:
//                         const Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                   ),
//                   items: [
//                     pics.promoBanner1,
//                     pics.promoBanner2,
//                     pics.promoBanner3,
//                   ].map((i) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.99,
//                             height: 250,
//                             // margin: EdgeInsets.symmetric(horizontal: 5.0),

//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: Image(
//                                 image: AssetImage(i),
//                                 fit: BoxFit.contain,
//                               ),
//                             ));
//                       },
//                     );
//                   }).toList(),
//                 )),
//                 const SizedBox(height: 20),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.5,
//               height: 60,
//               color: Colors.amber,
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                     autoPlay: true,
//                     autoPlayInterval: const Duration(seconds: 3),
//                     autoPlayAnimationDuration:
//                         const Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.elasticInOut,
//                     scrollDirection: Axis.vertical),
//                 items: [
//                   pics.promoText1,
//                   pics.promoText2,
//                   pics.promoText3,
//                   pics.promoText4
//                 ].map((i) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return SizedBox(
//                           child: Center(
//                             child: Text(
//                               i,
//                               style: GoogleFonts.poppins(
//                                   color: Colors.black,
//                                   fontSize: 23,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ));
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
            
//           ],
//         ),
//       )),
//     );
//   }
// }
