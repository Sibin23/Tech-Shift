import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';

class UpdateProcessor extends StatefulWidget {
  const UpdateProcessor({super.key});

  @override
  State<UpdateProcessor> createState() => _UpdateProcessorState();
}

class _UpdateProcessorState extends State<UpdateProcessor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('processor')
                .orderBy('name')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    // ignore: unused_local_variable
                    String imageUrl = document['image'];
                    String categoryName = document['name'];
                    // String categoryid = document['categoryid'];
                    return AdminUiHelper.updatelist(context, () {
                      AdminUi.customAlert(() { 
                        // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const EditProcessor()));
                      }, () { }, context);
                    },
                        imageUrl: imageUrl, categoryName: categoryName);
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
