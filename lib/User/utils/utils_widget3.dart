import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';

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
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctx) => const HomeInfo()),
                    ((route) => false));
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
      onTap: voidCallback,
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: imageurl.isEmpty
              ? Image.asset(
                  'assets/icons/profile.png',
                  color: Colors.black,
                )
              : Image.network(imageurl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  static cartSnackBar(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(spreadRadius: 2, blurRadius: 2, color: Colors.grey)
          ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Lottie.asset('assets/animations/cart.json',
                  width: 100, height: 100),
              const SizedBox(width: 10),
              Text('Added To Cart',
                  style:
                      TextStyle(color: Colors.purple.shade800, fontSize: 16)),
            ],
          ),
        ),
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          textColor: AppColors.appTheme,
          label: 'Dismiss',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  static itemDetails(BuildContext context,
      {required String title, required String subtitle}) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Text(title, style: TextStyling.subtitle2),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subtitle, style: TextStyling.details),
              ),
            ),
          ],
        ));
  }

  static custom1PcCard(BuildContext context,
      {required String title,
      required String name,
      required price,
      required String image}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black, spreadRadius: 0.5)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyling.subtitle3),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width * .53,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name == 'Not Needed' ? 'Not Selected' : name,
                        style: TextStyling.details),
                    Row(
                      children: [
                        Text('₹', style: TextStyling.subtitle),
                        const SizedBox(width: 3),
                        Text(
                            price.replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},"),
                            style: TextStyling.newP),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  static custom2PcCard(BuildContext context,
      {required String title,
      required String name,
      required price,
      required String image}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black, spreadRadius: 0.5)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .53,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name == 'Not Needed' ? 'Not Selected' : name,
                        style: TextStyling.details),
                    Row(
                      children: [
                        Text('₹', style: TextStyling.subtitle),
                        const SizedBox(width: 3),
                        Text(
                            price.replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},"),
                            style: TextStyling.newP),
                      ],
                    )
                  ],
                )),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: TextStyling.subtitle3),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
