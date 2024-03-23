import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Build%20page/build%20screen/build_details.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class ConfigDetail extends StatefulWidget {
  final Map<String, dynamic> pc;
  final String totalAmt;
  const ConfigDetail({super.key, required this.pc, required this.totalAmt});

  @override
  State<ConfigDetail> createState() => _ConfigDetailState();
}

class _ConfigDetailState extends State<ConfigDetail> {
  String card = 'Select a Graphics Card';
  String fan = 'Select a Cooler';
  String notNeed = 'Not Needed';
  @override
  Widget build(BuildContext context) {
    final custom = widget.pc;
    if (custom['gpu'] == card) {
      custom['gpu'] = notNeed;
    }
    if (custom['cooler'] == fan) {
      custom['cooler'] = notNeed;
    }

    String cofig = widget.pc['processor'];
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text('Your PC Configurations', style: TextStyling.subtitle3),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            addToCart(custom);
            userDetails(cofig);
            showSnackbarWithAnimation();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.appTheme,
              ),
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .07,
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyling.subtitleWhite,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Processor', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['processor'], price: custom['processorprice']),
              const SizedBox(height: 10),
              Text('Motherboard', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['motherboard'],
                  price: custom['motherboardprice']),
              const SizedBox(height: 10),
              Text('RAM (Memory)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['ram'], price: custom['ramprice']),
              const SizedBox(height: 10),
              Text('SSD (Storage)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['ssd'], price: custom['ssdprice']),
              const SizedBox(height: 10),
              Text('Graphics Card (GPU)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['gpu'], price: custom['gpuprice']),
              const SizedBox(height: 10),
              Text('Cabinet Case', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['cabinet'], price: custom['cabinetprice']),
              const SizedBox(height: 10),
              Text('CPU Coolers', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['cooler'], price: custom['coolerprice']),
              const SizedBox(height: 10),
              Text('Power Supply Unit (PSU)',
                  style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['psu'], price: custom['psuprice']),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .065,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Total Amount',
                              style: TextStyling.subtitleapptheme),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₹ ${widget.totalAmt}'.replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},"),
                            style: TextStyling.subtitleWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      )),
    );
  }

  Future<void> userDetails(String name) async {
    try {
      final user = FirebaseAuth.instance.currentUser!.uid;
      final data = {
        'uid': user,
        'cart': name};
      await FirebaseFirestore.instance
          .collection('UserDetails')
          .doc(user)
          .set(data);
    } catch (e) {
      alertMsg(e);
    }
  }

  alertMsg(e) {
    UiHelper.userSnackbar(context, e.toString());
  }

  Future<void> addToCart(Map<String, dynamic> pc) async {
    final updatedConfig = Map<String, dynamic>.from(widget.pc);
    updatedConfig['totalprice'] = widget.totalAmt;
    try {
      if (updatedConfig['gpu'] == 'Select a Graphics Card') {
        updatedConfig['gpu'] = notNeed;
      }
      final user = FirebaseAuth.instance.currentUser!;
      final userUid = user.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userUid);
      final cartCollectionRef = userDocRef.collection('Configuration').doc();
      await cartCollectionRef.set(updatedConfig);
    } catch (error) {
      alertMsg(error);
    }
  }

  void showSnackbarWithAnimation() {
    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.grey,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Lottie.asset('assets/Animations/cart.json',
                width: 100, height: 100),
            const SizedBox(width: 10),
            Text('Added To Cart',
                style: TextStyle(color: Colors.purple.shade800, fontSize: 16)),
          ],
        ),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        textColor: AppColors.appTheme,
        label: 'Dismiss',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((_) => navigate());
  }

  Future<void> navigate() async {
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const ScreenBuild()),
        (route) => false);
  }
}
