import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/update/textfields/cabinet.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';

class UpdateCabinet extends StatefulWidget {
  const UpdateCabinet({super.key});

  @override
  State<UpdateCabinet> createState() => _UpdateCabinetState();
}

class _UpdateCabinetState extends State<UpdateCabinet> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('cabinet')
                .orderBy('name')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    String imageUrl = document['image'];
                    String categoryid = document['categoryid'];
                    String cooler = document['cooler'];
                    String country = document['country'];
                    Map<String , dynamic> itemId = {
                      'categoryid': document.id,
                      'cooler': cooler,
                      'country': country,
                    };

                    return AdminUiHelper.updatelist(context, () {
                      AdminUi.customAlert(text1: 'Edit', text2: 'Delete', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => EditCabinet(
                                      itemId: itemId,
                                    )));
                      }, () {
                        Navigator.pop(context);
                      }, context);
                    }, imageUrl: imageUrl, categoryName: categoryid);
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
