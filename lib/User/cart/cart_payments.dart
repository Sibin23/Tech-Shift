import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/cart/cart_total_amount.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/user_home/user_home_privacy_policies.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/functions/fuctions.dart';

class Payments extends StatefulWidget {
  final Map<String, dynamic> user;
  const Payments({super.key, required this.user});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  bool? hasCartItems;
  bool isChecked = false;
  double? priceDifference;
  bool isLoading = false;
  bool? hasConfigure;
  bool isCheckedPolicy = false;
  @override
  void initState() {
    super.initState();
    _checkCartItems();
    _checkConfigure();
    calculatePriceDifferenceBeforeDeletion();
  }

  Future<void> loading() async {
    Future.delayed(const Duration(seconds: 3), () {
      orderSuccess(priceDifference!);
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _checkCartItems() async {
    final cartItems = await getCartItems();
    setState(() {
      hasCartItems = cartItems.isNotEmpty;
    });
  }

  Future<void> _checkConfigure() async {
    final custom = await getConfigure();
    setState(() {
      hasConfigure = custom.isNotEmpty;
    });
  }

  Future<void> addToOrders() async {
    if (hasCartItems == true) {
      final ordersRef = FirebaseFirestore.instance.collection('OrderOthers');
      final timestamp =
          DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
      String orderid = timestamp.substring(timestamp.length - 12);

      final cartItems = await getCartItems();
      final batch = FirebaseFirestore.instance.batch();
      for (final item in cartItems) {
        final itemExtra = {
          ...item,
          'date': DateTime.now().day,
          'month': DateTime.now().month,
          'year': DateTime.now().year.toString(),
          'orderid': orderid,
          'status': 'Pending'
        };
        final data = {...itemExtra, ...widget.user};

        final docRef = ordersRef.doc();
        batch.set(docRef, data);
      }
      await batch.commit();
      await clearCart();
      await clearFromAmount();
      await clearFromDetails();
    } else if (hasConfigure == true) {
      final ordersRef = FirebaseFirestore.instance.collection('OrderCustomPC');
      final time = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
      String id = time.substring(time.length - 12);
      final docRef = ordersRef.doc();
      final cartItems = await getConfigure();
      for (final item in cartItems) {
        final itemRef = ordersRef.doc(docRef.id);

        final itemExtra = {
          ...item,
          'date': DateTime.now().day,
          'month': DateTime.now().month,
          'year': DateTime.now().year.toString(),
          'orderid': id,
          'status': 'Pending'
        };
        final data = {...itemExtra, ...widget.user};
        await itemRef.set(data);
      }
      await clearFromCustomPc();
      await clearFromAmount();
      await clearFromDetails();
    }
  }

  Future<void> clearFromAmount() async {
    priceDifference = await calculatePriceDifferenceBeforeDeletion();
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userUid)
        .collection('Amount');

    final querySnapshot = await cartCollectionRef.get();
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<double> calculatePriceDifferenceBeforeDeletion() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userUid)
        .collection('Amount');

    double totalPriceDifference = 0.0;

    final querySnapshot = await cartCollectionRef.get();
    for (final doc in querySnapshot.docs) {
      final data = doc.data();

      final newPrice =
          data.containsKey('newprice') ? data['newprice'] as double : 0.0;
      final oldPrice =
          data.containsKey('oldprice') ? data['oldprice'] as double : 0.0;

      final priceDifference = oldPrice - newPrice;
      totalPriceDifference += priceDifference;
    }

    return totalPriceDifference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: isLoading == true
            ? null
            : Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 40, right: 40, bottom: 15),
                  child: UiHelper.buttonSml(
                    context,
                    () {
                      setState(() {
                        if (isChecked == true && isCheckedPolicy == true) {
                          isLoading = true;
                          loading();
                          addToOrders();
                        } else if (isChecked == false) {
                          UiHelper.userSnackbar(
                              context, 'Please Select Cash On Delivery');
                        }else if(isCheckedPolicy == false){
                          UiHelper.userSnackbar(context, 'Please Select Privacy Policy');
                        }
                      });
                    },
                    text: 'Confirm Order',
                  ),
                ),
              ),
        appBar: isLoading == true
            ? null
            : AppBar(
                title: const Text('Payments'),
              ),
        body: isLoading == true
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Loading',
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey, fontSize: 23)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .07,
                                      child: Lottie.asset(
                                          'assets/animations/order_loading.json')),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Lottie.asset('assets/animations/order2.json',
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * .4,
                            width: MediaQuery.of(context).size.width,
                            filterQuality: FilterQuality.high,
                            frameRate: FrameRate.max),
                      ],
                    ),
                  ],
                ),
              )
            : SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 1.3)
                          ]),
                      child: Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .4,
                              child: Lottie.asset('assets/animations/cod.json',
                                  fit: BoxFit.contain)),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Cash On Delivey',
                                        style: TextStyling.appTitle),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .06,
                                        child: Image.asset(
                                            'assets/icons/images.jpeg.jpg',
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high))
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text('Your Orders',
                                    style: TextStyling.appTitle),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const TotalAmout(),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (newValue) => setState(() {
                                        isChecked = !isChecked;
                                      }),
                                    ),
                                    Text('Cash on delivery',
                                        style: TextStyling.subtitle3),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Text(
                                    'Your personal data is used only for internal functions within the app, such as displaying your user information and purchase history. While this app doesn\'t support buying or selling products, the cash on delivery option is included to enhance your user experience.  For more details, please refer to our privacy policy.',
                                    style: TextStyling.categoryText),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: isCheckedPolicy,
                                        onChanged: (newValue) {
                                          setState(() {
                                            isCheckedPolicy = newValue!;
                                          });
                                        }),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const HomePrivacyPolicy()));
                                        },
                                        child: Row(
                                          children: [
                                            Text('Agree with ',style: TextStyling.categoryText,),
                                            const Text(
                                              'Privacy policy',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  void orderSuccess(double priceDifference) {
    AnimatedSnackBar.rectangle(
      'Order Confirmed Successfully',
      'You Saved ₹ ${priceDifference.toStringAsFixed(2)}',
      type: AnimatedSnackBarType.success,
      animationCurve: Curves.easeInOut,
      duration: const Duration(seconds: 2),
      brightness: Brightness.light,
    ).show(context);
    toHome();
  }

  toHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const HomeInfo()),
        (route) => false);
  }
}
