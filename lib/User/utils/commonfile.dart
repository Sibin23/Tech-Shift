import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

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

// Categories

  static List<String> categories = [
    'assets/Categories/keyboard.png',
    'assets/Categories/headset.jpg',
    'assets/Categories/processor.png',
    'assets/Categories/Cabinet.jpg',
    'assets/Categories/Chair.png',
    'assets/Categories/Mouse.webp',
  ];
  static List<String> categoriesName = [
    'Gaming Keyboard',
    'Gaming Headsets',
    'Processos',
    'Gaming Cabinets',
    'Gaming Chairs',
    'Gaming Mouse',
  ];
}

class UiHelper {
  // alert dialogue
  static customAlertBox(BuildContext context, String text) {
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
                    style: CustomText.title2,
                  ))
            ],
          );
        });
  }

  // custom Textfield
  static customTextField({
    required TextEditingController controller,
    required String text,
    required IconData iconData,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        label: Text(text,style: TextStyling.subtitleWhite,),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
// Elevated button
  static customButton(VoidCallback voidCallback, String text, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: () {
        voidCallback();
      },
      child: Text(
        text,
        style: TextStyling.subtitleWhite,
      ),
    );
  }

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
                      oldamt,
                      style: const TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  currentamt,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
