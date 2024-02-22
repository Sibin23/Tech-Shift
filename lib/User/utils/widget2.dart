import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class UiCustom {
  // prebuild item card
  static preBuildCard(BuildContext context,VoidCallback voidCallback,
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
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(child: CircularProgressIndicator());
                    },),
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
                    Text(oldPrice, style: TextStyling.lineThrough),
                  ]),
                  const SizedBox(width: 10),
                  Text(newPrice, style: TextStyling.newP)
                ])
              ]))),
    );
  }
  static rating(){
    return RatingStars(
        editable: false,
        rating: 3.5,
        color: Colors.green,
        iconSize: 20,
      );
  }
}
