import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Profile/Account/add_account.dart';
import 'package:prosample_1/User/Profile/Account/update_profile.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

class NoUser extends StatefulWidget {
  const NoUser({super.key});

  @override
  State<NoUser> createState() => _NoUserState();
}

class _NoUserState extends State<NoUser> {
  alert(e) {
    UiHelper.customTextAlert(context, 'Error Occured: ${e.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * .1,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const UpdateProfile()));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .2,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .06,
                        child: Image.asset('assets/icons/Edit_icon.png',
                            color: Colors.white)),
                    const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .where('userid', isEqualTo: id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return UiHelper.customTextAlert(
                      context, 'Error Occured: ${snapshot.error.toString()}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final userDocs = snapshot.data!.docs;

                if (userDocs.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(height: 60),
                      Center(
                          child: Lottie.asset(
                              'assets/Animations/Animation - 1708060808685.json',
                              fit: BoxFit.cover)),
                      const Text('No user profile found. Add user'),
                      const SizedBox(height: 30),
                      UiHelper.buttonSml(context, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const AddUserScreen()));
                      }, text: 'Add Profile')
                    ],
                  );
                }
                if (userDocs.isNotEmpty) {
                  final userDoc = userDocs.first;
                  final userData = userDoc.data();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .4,
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.black.withOpacity(.99),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .27,
                              child: Image.asset(
                                'assets/Ads section/profilebg.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.15,
                              left: MediaQuery.of(context).size.width * .25,
                              right: MediaQuery.of(context).size.width * .25,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 3,
                                height:
                                    MediaQuery.of(context).size.height * .23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(110),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.5),
                                      spreadRadius: 2.0,
                                      blurRadius: 2.0,
                                    ),
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 206, 184, 210)
                                          .withOpacity(0.3),
                                      spreadRadius: 2.0,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: userData['imageUrl'],
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userData['name'],
                                  style: TextStyling.appTitle),
                              Text(email.toString())
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('PHONE', style: TextStyling.subtitleapptheme),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0.4,
                                        color: AppColors.appTheme)
                                  ]),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .07,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(userData['phNum'],
                                    style: TextStyling.subtitleapptheme),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('ADDRESS',
                                style: TextStyling.subtitleapptheme),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0.4,
                                        color: AppColors.appTheme)
                                  ]),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "${userData['home']}, ${userData['street']}, ${userData['city']},${userData['state']}, ${userData['pincode']}.",
                                    style: TextStyling.subtitleapptheme),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UiHelper.buttonSml(context, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const UpdateProfile()));
                          }, text: 'Edit Profile')
                        ],
                      )
                    ],
                  );
                }
                return const Center(child: Text('Loading'));
              }),
        ));
  }
}
