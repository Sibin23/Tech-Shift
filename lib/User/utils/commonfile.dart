import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class Pics {
  // Banners
  static const String promoBanner1 = 'assets/Ads section/caliber-r3.webp';
  static const String promoBanner2 = 'assets/Ads section/Logitech.webp';
  static const String promoBanner3 = 'assets/Ads section/Lianli.jpg';

// Promo Text

  static const String promoText1 = '// Gaming //';
  static const String promoText2 = '// Editing //';
  static const String promoText3 = '// Coding //';
  static const String promoText4 = '// Streaming //';
}

class UiHelper {
  // custom Textfield
  static customTextField({
    required TextEditingController controller,
    required String labeltext,
    required IconData iconData,
    required String validate,
    bool obscureText = false,
    keyboardType = TextInputType.text,
  }) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validate;
          }
          return null;
        },
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            label: Text(labeltext, style: TextStyling.subtitleapptheme),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
  }

  // alert dialogue
  static customTextAlert(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyling.subtitleapptheme,
                  ))
            ],
          );
        });
  }

// Elevated button
  static customButton(BuildContext context, VoidCallback voidCallback,
      {required String text}) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.appTheme,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(4.0, 4.0),
              )
            ]),
        child: Center(child: Text(text, style: TextStyling.subtitleWhite)),
      ),
    );
  }

// itemcard
  static itemCard({
    required String image,
    required String category,
    required String subtitle,
    required String oldamt,
    required String currentamt,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                width: 130,
                height: 130,
                child: Image(image: AssetImage(image))),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyling.categoryText,
                ),
                Text(subtitle, style: TextStyling.subtitle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.currency_rupee),
                    Text(
                      oldamt.replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => "${m[1]},"),
                      style: const TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  currentamt.replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => "${m[1]},"),
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// snackbar
  static userSnackbar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: TextStyling.subtitleWhite,
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
