import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/cart/address.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ProceedButton extends StatefulWidget {
  const ProceedButton({super.key});

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton> {
  bool? hasOthersData;
  bool? hasCustomData;
  bool? hasUser;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> checkUser() async {
    final user = FirebaseFirestore.instance.collection('User').doc(userId);
    final querySnapshot = await user.get();
    hasUser = querySnapshot.exists;
  }

  Future<void> fetchConfigure() async {
    final custom = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Configuration');
    final querySnapshot = await custom.get();
    hasCustomData = querySnapshot.docs.isNotEmpty;
  }

  Future<void> fetchData() async {
    final data = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('others');

    final querySnapshot = await data.get();
    hasOthersData = querySnapshot.docs.isNotEmpty;
  }

  @override
  void initState() {
    fetchData();
    checkUser();
    fetchConfigure();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasOthersData == true && hasUser == true ||
            hasCustomData == true && hasUser == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const Address()));
        }
        if (hasOthersData == false && hasCustomData == false) {
          noItem();
        }
        if (hasUser == false) {
          noUser();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: AppColors.appTheme),
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Center(
            child: Text(
          'Proceed',
          style: TextStyling.buttonWhite,
        )),
      ),
    );
  }

  void noUser() {
    AnimatedSnackBar.rectangle('No User Data!!', 'Please Add Profile Details',
            type: AnimatedSnackBarType.warning,
            brightness: Brightness.light,
            animationCurve: Curves.easeInOut,
            duration: const Duration(seconds: 3))
        .show(context);
  }

  void noItem() {
    AnimatedSnackBar.rectangle('No Cart Items!!', 'Please Any Item',
            type: AnimatedSnackBarType.warning,
            brightness: Brightness.light,
            animationCurve: Curves.easeInOut,
            duration: const Duration(seconds: 3))
        .show(context);
  }
}
