import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ProductDetails {
  static productInfo1(BuildContext context, VoidCallback voidCallback1,
      VoidCallback voidCallback2, bool isFavorite,
      {required String image,
      required String name,
      required String newPrice,
      required oldPrice}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) {
                      return const Center(child: CircularProgressIndicator());
                    }))),
        Container(
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey,
                      spreadRadius: 2,
                      offset: Offset(2, 2))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                    right: Radius.elliptical(40, 20),
                    left: Radius.elliptical(40, 20))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                      onTap: () async {
                        voidCallback1();
                      },
                      child: isFavorite
                          ? const Icon(Icons.favorite,
                              size: 30, color: Colors.red)
                          : const Icon(Icons.favorite_border_outlined,
                              size: 30, color: Colors.black)),
                ),
              ),
              Column(children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .73,
                                child: Text(
                                  name,
                                  style: TextStyling.subtitle3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text('4.0', style: TextStyling.rating),
                              Icon(
                                Icons.star,
                                color: AppColors.appTheme,
                                size: 20,
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text('₹', style: TextStyling.subtitle2),
                                  const SizedBox(width: 3),
                                  Text(
                                      newPrice.replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => "${m[1]},"),
                                      style: TextStyling.newPbig),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(children: [
                                Text('₹', style: TextStyling.subtitle2),
                                const SizedBox(width: 3),
                                Text(
                                    oldPrice.replaceAllMapped(
                                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                        (Match m) => "${m[1]},"),
                                    style: TextStyling.oldGreyinfo),
                              ]),
                            ],
                          ),
                          const Divider(thickness: 1),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.local_shipping,
                                              color: AppColors.appTheme,
                                              size: 30),
                                          const SizedBox(width: 5),
                                          Text(
                                            'All India Shiping',
                                            style: TextStyling.categoryText,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.payments_outlined,
                                              color: AppColors.appTheme,
                                              size: 25),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Competitive Price',
                                            style: TextStyling.categoryText,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: AppColors.appTheme,
                                              size: 30),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Branded Products',
                                            style: TextStyling.categoryText,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                              Icons
                                                  .admin_panel_settings_rounded,
                                              color: AppColors.appTheme,
                                              size: 30),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Secured Shoping',
                                            style: TextStyling.categoryText,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ])),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            voidCallback2();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.appTheme,
                                    spreadRadius: 1,
                                  )
                                ]),
                            width: MediaQuery.of(context).size.width * .35,
                            height: MediaQuery.of(context).size.height * .055,
                            child: Center(
                              child: Text('See Details..',
                                  style: TextStyling.subtitleapptheme),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ]))
      ]),
    );
  }
}
