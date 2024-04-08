import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/profile/profile_logout_button.dart';
import 'package:prosample_1/User/profile/profiel_custompc_order_button.dart';
import 'package:prosample_1/User/profile/profile_nouser.dart';
import 'package:prosample_1/User/profile/profile_order_history_button.dart';
import 'package:prosample_1/User/profile/profile_update_account.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                  return const AccountNoUser();
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
                                'assets/ads/profilebg.png',
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
                                    MediaQuery.of(context).size.height * .232,
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
                                  child: userData['imageUrl'] != null
                                      ? CachedNetworkImage(
                                          imageUrl: userData['imageUrl']!,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                          placeholder: (context, url) =>
                                              const Image(
                                            image: AssetImage(
                                                'assets/icons/profile.png'),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Image(
                                            image: AssetImage(
                                                'assets/icons/profile.png'),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              'assets/icons/profile.png'),
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
                          Text(userData['name'], style: TextStyling.appTitle),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const UpdateProfile()));
                              },
                              icon: Image.asset('assets/icons/Edit_icon.png',
                                  width:
                                      MediaQuery.of(context).size.width * .12,
                                  color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.6,
                                    color: AppColors.appTheme)
                              ]),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .07,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Email', style: TextStyling.subtitle),
                                Text(email.toString(),
                                    style: TextStyling.subtitleapptheme),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.6,
                                    color: AppColors.appTheme)
                              ]),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .07,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mobile No.', style: TextStyling.subtitle),
                                Text(userData['phNum'],
                                    style: TextStyling.subtitleapptheme)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const OrdersHistoryButto(),
                      const Divider(),
                      const CustomPcButton(),
                      const Divider(),
                      const LogOut(),
                      const Divider(),
                    ],
                  );
                }
                return const Center(child: Text('Loading'));
              }),
        ));
  }
}
