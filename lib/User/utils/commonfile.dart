import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';


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

  static const String keyBoard = 'Gaming Keyboard';
  static const String headSets = 'Gaming Headsets';
  static const String processor = 'Processors';
  static const String cabinet = 'Gaming Cabinets';
  static const String chair = 'Gaming Chairs';
  static const String mouse = 'Gaming Mouse';

  List<String> categories = [
    'assets/Categories/keyboard.png',
    'assets/Categories/headset.jpg',
    'assets/Categories/Processor.avif',
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
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
  // custom Textfield
  static customTextField(TextEditingController controller, String text, IconData iconData,){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    );
  }

  static customButton(VoidCallback voidCallback, String text){
    return SizedBox(
      height: 50,width: 200,child: ElevatedButton(onPressed: (){
        voidCallback();
      }, child: Text(text,style: TextStyling.subtitle,),),
    );
  }
 
}
