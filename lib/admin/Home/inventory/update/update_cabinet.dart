import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';

class UpdateCabinet extends StatefulWidget {
  const UpdateCabinet({super.key});

  @override
  State<UpdateCabinet> createState() => _UpdateCabinetState();
}

class _UpdateCabinetState extends State<UpdateCabinet> {
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

                    return AdminUiHelper.updatelist(context, () {
                      AdminUi.customAlert(() { 
                        Navigator.pop(context);
                      }, () { 
                        Navigator.pop(context);
                      }, context);
                    },
                        imageUrl: imageUrl, categoryName: categoryid);
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
