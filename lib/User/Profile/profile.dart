import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Profile/Account/no_user.dart';
import 'package:prosample_1/User/Profile/contact_page.dart';
import 'package:prosample_1/User/Profile/terms_policies.dart';
import 'package:prosample_1/User/Profile/warranty_policy.dart';
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
    final user = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text('Hi,', style: TextStyling.appTitle),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(user.toString(),style: TextStyling.appTitle)),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const NoUser()));
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
                             Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ScreenContact()));
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
                      Text('More Information', style: TextStyling.titleText2),
                      const SizedBox(height: 10),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const WarrantyPolicy()));
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
                                  Text('Warranty Policies',
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
            const SizedBox(height: 100),
            UiHelper.buttonSml(context, () async {
              await FirebaseAuth.instance.signOut();
              logout();
            }, text: 'Logout'),
            const SizedBox(height: 10),
          ],
        ),
      )),
    );
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
        (route) => false);
  }
}
