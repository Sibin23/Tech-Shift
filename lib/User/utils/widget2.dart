import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class UiCustom {
  static preBuildCard(BuildContext context, VoidCallback voidCallback,
      {required String imageUrl,
      required String categoryName,
      required String oldPrice,
      required String newPrice,
      required String cabinet}) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(4.0, 4.0))
              ]),
          width: MediaQuery.of(context).size.width * 0.02,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ]),
                    Text(categoryName, style: TextStyling.categoryText),
                    Text(cabinet,
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text('****', style: TextStyling.subtitle),
                    Row(children: [
                      Row(children: [
                        Text(
                          '₹',
                          style: TextStyling.subtitle3,
                        ),
                        const SizedBox(width: 5),
                        Text(
                            oldPrice.replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},"),
                            style: TextStyling.lineThrough),
                      ]),
                      const SizedBox(width: 10),
                      Text(
                          newPrice.replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => "${m[1]},"),
                          style: TextStyling.newP)
                    ])
                  ]))),
    );
  }

  static bottomNextButton(BuildContext context, VoidCallback voidCallbackprev,
      VoidCallback voidCallbacknext
      //,{required String amt}
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                voidCallbackprev();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1.2,
                      color: AppColors.appTheme,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width * .35,
                height: MediaQuery.of(context).size.height * .07,
                child: Center(
                  child: Text(
                    'Back',
                    style: TextStyling.subtitleapptheme,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                voidCallbacknext();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.appTheme,
                ),
                width: MediaQuery.of(context).size.width * .35,
                height: MediaQuery.of(context).size.height * .07,
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyling.subtitleWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static rating() {
    return RatingStars(
      editable: false,
      rating: 3.5,
      color: Colors.green,
      iconSize: 20,
    );
  }

  static configBox(BuildContext context) {
    return Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1)
                ]),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: const Center(
                          child: Text('Not Required',
                              style: TextStyle(color: Colors.transparent)),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration:
                          const BoxDecoration(color: Colors.black),
                      child: Center(
                          child: Text(
                              '₹ 0',
                              style: TextStyling.subtitleWhite)),
                    )
                  ],
                ),
              );
  }
  static configDetail( BuildContext context,{required String name, required String price}){
    return Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1)
                ]),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Center(
                          child: Text(name.toString(),
                              style: TextStyling.details),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration:
                          const BoxDecoration(color: Colors.black),
                      child: Center(
                          child: Text(
                              '₹ $price'.replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => "${m[1]},"),
                              style: TextStyling.subtitleWhite)),
                    )
                  ],
                ),
              );
  }
}
