import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/login.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logOut();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .05,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.logout, color: Colors.black,size: 25),
                  const SizedBox(width: 10),
                  Text('Log Out', style: TextStyling.subtitle2),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.appTheme)
            ],
          ),
        ),
      ),
    );
  }

  logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Alert box content and functionality
        return AlertDialog(surfaceTintColor: Colors.white,
          title: Text('Logout',style: TextStyling.appTitle,),
          content: Text('Are You Sure You Want To Logout?', style: TextStyling.details,),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: () async{
              await FirebaseAuth.instance.signOut();
              logout();
            }, child: const Text('Logout'))
          ],
        );
      },
    );
  }
   void logout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
        (route) => false);
  }
}
