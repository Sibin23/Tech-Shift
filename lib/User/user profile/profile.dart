import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:prosample_1/User/user%20profile/contact_page.dart';

import 'package:prosample_1/User/user%20profile/sample.dart';

import 'package:prosample_1/User/user%20profile/terms_policies.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/login.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                children: [
                  const SizedBox(),
                  Text('Hi, sibin@gmail.com', style: TextStyling.titleText),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (ctx) =>  const ScreenMyAccount()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.appTheme,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(4.0, 4.0))
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.person_rounded,
                                          color: Colors.white),
                                      Text('My Account',
                                          style: TextStyling.subtitleWhite),
                                    ]))),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const SamapleScreen()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.appTheme,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(4.0, 4.0))
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.call,
                                          color: Colors.white),
                                      Text('Contact Us',
                                          style: TextStyling.subtitleWhite),
                                    ])))
                      ]),
                  const SizedBox(height: 20),
                  const Divider(thickness: 2),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('More Information', style: TextStyling.titleText),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const TermsAndPolicy()));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.93,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.view_list_outlined,
                                      color: AppColors.appTheme),
                                  Text('Terms and Policies',
                                      style: TextStyling.titleText2),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.appTheme,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            UiHelper.customButton(context, () {
              logout();
            }, text: 'Logout'),
          ],
        ),
      )),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
        (route) => false);
  }
  
  //  goToProfile() {
  //    final Box profileBox = Hive.box('userProfile');
  // final isProfileAvailable = profileBox.containsKey('name');

  // if (isProfileAvailable) {
  //   // ProfileDetais(userData: profileBox.get('data'))
  //   return; // Replace with actual data mapping
  // } else {
  //   return const ScreenMyAccount();
  // }
  // }
}
