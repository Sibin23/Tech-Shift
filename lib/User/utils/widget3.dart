import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/build%20screen/build_details.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class UiCustom2 {
  static customBotNav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  deleteAlertBox(context);
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
                      'Delete',
                      style: TextStyling.subtitleWhite,
                    )))),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                      'Continue',
                      style: TextStyling.subtitleWhite,
                    )))),
          ],
        ),
      ),
    );
    
  }

  static deleteAlertBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete !'),
          content: const Text(
              'Do you want to delete? This will remove all your configurations.'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context), // Close dialog without deleting
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> const ScreenBuild()), ((route) => false));
                
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
    static profileImage(VoidCallback voidCallback, {required imageurl}) {
    return GestureDetector(
        onTap: () {
          voidCallback();
        },
        child: Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          child: imageurl.isEmpty
              ? const Center(child: Text('Pick an Image'))
              : Image.network(imageurl),
        ));
  }
}
