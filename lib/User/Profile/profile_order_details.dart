import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileOrderDetails extends StatefulWidget {
  final String uid, orderId;
  const ProfileOrderDetails(
      {super.key, required this.uid, required this.orderId});

  @override
  State<ProfileOrderDetails> createState() => _ProfileOrderDetailsState();
}

class _ProfileOrderDetailsState extends State<ProfileOrderDetails> {
  bool isLoading = false;
  Map<String, dynamic> item = {};
  Future<Map<String, dynamic>> getDetails() async {
    FirebaseFirestore.instance
        .collection('OrderOthers')
        .where('uid', isEqualTo: widget.uid)
        .where('orderid', isEqualTo: widget.orderId)
        .get()
        .then((value) {
      setState(() {
        item = value.docs.first.data();
      });
    });
    return item;
  }
Future<void> loading() async{
  
}
  @override
  void initState() {
    loading();
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading == true? const Text('Loading'): SafeArea(
        child: Column(
          children: [
            Text(item['orderid']),
            Text(item['name']),
            Text(item['username'])
          ],
        ),
      ),
    );
  }
}
