import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/cart/cart_buynow_payments.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class CartBuyNowAddress extends StatefulWidget {
  const CartBuyNowAddress({super.key});

  @override
  State<CartBuyNowAddress> createState() => _CartBuyNowAddressState();
}

class _CartBuyNowAddressState extends State<CartBuyNowAddress> {
  final name = TextEditingController();
  final phNum = TextEditingController();
  final pincode = TextEditingController();
  final area = TextEditingController();
  final locality = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final houseNum = TextEditingController();
  String? image;
  bool hasOthersData = false;
  Map<String, dynamic>? user;
  Future<void> fetchUser() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        image = data['imageUrl'];
        name.text = data['name'];
        phNum.text = data['phNum'];
        pincode.text = data['pincode'];
        houseNum.text = data['home'];
        city.text = data['city'];
        state.text = data['state'];
        locality.text = data['locality'];
        area.text = data['street'];
        setState(() {
          hasOthersData = true;
        });
      }
    });
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white),
      bottomNavigationBar: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
            child: UiHelper.buttonSml(context, () {
              final id = FirebaseAuth.instance.currentUser!.uid;
              final mail = FirebaseAuth.instance.currentUser!.email;
              final userData = {
                'email': mail,
                'userimage': image,
                'uid': id,
                'username': name.text,
                'phnum': phNum.text,
                'pincode': pincode.text,
                'area': area.text,
                'house': houseNum.text,
                'locality': locality.text,
                'city': city.text,
                'state': state.text,
              };
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => CartBuyNowPayments(
                            user: userData,
                          )));
            }, text: 'Place Order'),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping', style: TextStyling.appTitle),
                const SizedBox(height: 30),
                space,
                Text('Contact information', style: TextStyling.subtitle3),
                space,
                UiHelper.profileTextField(
                    controller: name,
                    text: 'Full Name*',
                    validate: 'Name is required'),
                space,
                UiHelper.profileTextField(
                    controller: phNum,
                    text: 'Mobile No*',
                    validate: 'Mobile No. is required'),
                space,
                space,
                Text('Shipping Address', style: TextStyling.subtitle3),
                space,
                UiHelper.profileTextField(
                    controller: pincode,
                    text: 'Pincode*',
                    validate: 'Pincode is required'),
                space,
                UiHelper.profileTextField(
                    text: 'House No./Building No*',
                    controller: houseNum,
                    validate: 'House No. is required'),
                space,
                UiHelper.profileTextField(
                    controller: area,
                    text: 'Street/Area*',
                    validate: 'Pincode is required'),
                space,
                UiHelper.profileTextField(
                    controller: locality,
                    text: 'Locality/Town*',
                    validate: 'Locality is required'),
                space,
                Row(
                  children: <Widget>[
                    Flexible(
                      child: UiHelper.profileTextField(
                          controller: city,
                          text: 'City*',
                          validate: 'City is required'),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: UiHelper.profileTextField(
                          controller: state,
                          text: 'State*',
                          validate: 'State is required'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
