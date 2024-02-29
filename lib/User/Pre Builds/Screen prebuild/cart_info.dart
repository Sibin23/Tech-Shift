// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:prosample_1/User/Pre%20Builds/details.dart';
// import 'package:prosample_1/User/utils/colors.dart';
// import 'package:prosample_1/User/utils/text_decorations.dart';
// import 'package:prosample_1/User/utils/widget2.dart';

// class CartinfoPrebuid extends StatefulWidget {
//   final String prebuild;
//   const CartinfoPrebuid({super.key, required this.prebuild});

//   @override
//   State<CartinfoPrebuid> createState() => _CartinfoPrebuidState();
// }

// class _CartinfoPrebuidState extends State<CartinfoPrebuid> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('prebuild')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text("Error: ${snapshot.error}");
//                   }

//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final documents = snapshot.data!.docs;
                    
//                   final filteredDocs = widget.prebuild != null
//                       ? documents.where((doc) => doc.id == widget.prebuild)
//                       : documents;
                 
//                   return filteredDocs.isNotEmpty
//                       ? Column(children: [
//                           SizedBox(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height * 0.25,
//                               child: Center(
//                                 child: Center(
//                                   child: CachedNetworkImage(
//                                     imageUrl: widget.prebuild['image'],
//                                     placeholder: (context, url) => const Center(
//                                         child: CircularProgressIndicator()),
//                                   ),
//                                 ),
//                               )),
//                           Container(
//                             decoration: const BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                       blurRadius: 4,
//                                       color: Colors.grey,
//                                       spreadRadius: 2,
//                                       offset: Offset(2, 2))
//                                 ],
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.horizontal(
//                                     right: Radius.elliptical(40, 20),
//                                     left: Radius.elliptical(40, 20))),
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height,
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             name,
//                                             style: TextStyling.titleText,
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 20),
//                                       Row(
//                                         children: [
//                                           UiCustom.rating(),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text('₹',
//                                                   style: TextStyling.subtitle),
//                                               const SizedBox(width: 3),
//                                               Text(
//                                                   newPrice.replaceAllMapped(
//                                                       RegExp(
//                                                           r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                                                       (Match m) => "${m[1]},"),
//                                                   style: TextStyling.newPbig),
//                                             ],
//                                           ),
//                                           const SizedBox(width: 15),
//                                           Row(children: [
//                                             Text('₹',
//                                                 style: TextStyling.subtitle),
//                                             const SizedBox(width: 3),
//                                             Text(
//                                                 oldPrice.replaceAllMapped(
//                                                     RegExp(
//                                                         r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                                                     (Match m) => "${m[1]},"),
//                                                 style: TextStyling.oldGreyinfo),
//                                           ]),
//                                         ],
//                                       ),
//                                       const Divider(thickness: 1),
//                                       const SizedBox(height: 50),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.14,
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Icon(Icons.local_shipping,
//                                                         color:
//                                                             AppColors.appTheme,
//                                                         size: 30),
//                                                     const SizedBox(width: 5),
//                                                     Text(
//                                                       'All India Shiping',
//                                                       style: TextStyling
//                                                           .categoryText,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                         Icons.payments_outlined,
//                                                         color:
//                                                             AppColors.appTheme,
//                                                         size: 25),
//                                                     const SizedBox(width: 5),
//                                                     Text(
//                                                       'Competitive Price',
//                                                       style: TextStyling
//                                                           .categoryText,
//                                                     )
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 20),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Icon(Icons.check_circle,
//                                                         color:
//                                                             AppColors.appTheme,
//                                                         size: 30),
//                                                     const SizedBox(width: 5),
//                                                     Text(
//                                                       'Branded Products',
//                                                       style: TextStyling
//                                                           .categoryText,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                         Icons
//                                                             .admin_panel_settings_rounded,
//                                                         color:
//                                                             AppColors.appTheme,
//                                                         size: 30),
//                                                     const SizedBox(width: 5),
//                                                     Text(
//                                                       'Secured Shoping',
//                                                       style: TextStyling
//                                                           .categoryText,
//                                                     )
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(height: 20),
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (ctx) =>
//                                                         PreBuildDetails(
//                                                             prebuild:
//                                                                 prebuild)));
//                                           },
//                                           child: const Text(
//                                             'View More',
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         .05),
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: AppColors.appTheme),
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(6)),
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.06,
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.45,
//                                           child: Center(
//                                               child: Text('Buy Now',
//                                                   style: TextStyling.buttonB))),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 color: AppColors.appTheme,
//                                                 borderRadius:
//                                                     BorderRadius.circular(6)),
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.06,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.45,
//                                             child: Center(
//                                                 child: Text('Add to Cart',
//                                                     style:
//                                                         TextStyling.buttonW))),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ])
//                       : const Center(
//                           child:
//                               Text('No data found for the provided item ID.'),
//                         );
//                 })));
//   }
// }
