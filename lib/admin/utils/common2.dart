import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class AdminUiHelper {
  // save button
  static customButton(BuildContext context, VoidCallback voidCallback,
      {required String text}) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .075,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.appTheme,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(4.0, 4.0),
              )
            ]),
        child: Center(child: Text(text, style: CustomText.apptitle)),
      ),
    );
  }

  // update list container
  static updatelist(
    BuildContext context,
    VoidCallback voidCallback, {
    required imageUrl,
    required categoryName,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          voidCallback();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  offset: Offset(3.0, 3.0),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .22,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 5),
                    Text(
                      categoryName,
                      style: CustomText.categoryTitleText,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // image box
  static customImageBox(VoidCallback voidCallback, {required imageurl}) {
    return GestureDetector(
        onTap: () {
          voidCallback();
        },
        child: Expanded(
            child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: imageurl.isEmpty
                    ? const Center(child: Text('Pick an image'))
                    : Image.network(imageurl.toString(), fit: BoxFit.cover))));
  }

  static customSnackbar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: CustomText.subtitleWhite,
          ),
        ],
      ),
      backgroundColor: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(10.0),
      // Adjust animation and behavior:
      duration: const Duration(seconds: 3),
      elevation: 8.0,
      behavior: SnackBarBehavior.floating,
    ));
  }
}