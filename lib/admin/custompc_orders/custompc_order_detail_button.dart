import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

class CustomPCorderDetailButton extends StatefulWidget {
  final String orderId;
  final String uid;
  const CustomPCorderDetailButton(
      {super.key, required this.orderId, required this.uid});

  @override
  State<CustomPCorderDetailButton> createState() =>
      _CustomPCorderDetailButtonState();
}

class _CustomPCorderDetailButtonState extends State<CustomPCorderDetailButton> {
  Future<void> customPcStatus(String updateStatus) async {
    final docRef = FirebaseFirestore.instance
        .collection(customPc)
        .where(orderId, isEqualTo: widget.orderId)
        .where(uid, isEqualTo: widget.uid);

    final querySnapshot = await docRef.get();
    if (querySnapshot.docs.isNotEmpty) {
      final document = querySnapshot.docs.first;
      final docId = document.id;
      await FirebaseFirestore.instance
          .collection(customPc)
          .doc(docId)
          .update({status: updateStatus});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                String status = cancelled;
                customPcStatus(status);
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 3))
                    ]),
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * .07,
                child: Center(
                    child:
                        Text('Cancel Order', style: CustomText.subtitleWhite)),
              ),
            ),
            GestureDetector(
              onTap: () {
                String status = confirmed;
                customPcStatus(status);
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 3))
                    ],
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * .07,
                child: Center(
                    child:
                        Text('Confirm Order', style: CustomText.subtitleWhite)),
              ),
            ),
          ],
        ));
  }
}
