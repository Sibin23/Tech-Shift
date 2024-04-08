import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/prebuild_pc/prebuild_pc_add.dart';
import 'package:prosample_1/admin/prebuild_pc/prebuild_pc_update.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ListPreBuildState extends StatefulWidget {
  const ListPreBuildState({super.key});

  @override
  State<ListPreBuildState> createState() => __ListPreBuildStateState();
}

class __ListPreBuildStateState extends State<ListPreBuildState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.appTheme,
        title: Text('List Pre-Builds', style: CustomText.apptitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const ScreenPreBuild()));
                },
                icon: Image.asset('assets/icons/add.png',
                    width: 30, color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('prebuild')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];

                        String itemId = document.id;
                        String imageUrl = document['image'];
                        String categoryName = document['name'];

                        return AdminUiHelper.updatelist(context, () {
                          AdminUi.customAlert(text1: 'Edit', text2: 'Delete',
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => EditPC(
                                          itemId: itemId,
                                        )));
                          }, () {
                            deleteData(itemId);
                            AdminUiHelper.customSnackbar(
                                context, 'Item Deleted Successfully !');
                          }, context);
                        }, imageUrl: imageUrl, categoryName: categoryName);
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ))),
    );
  }

  Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('prebuild').doc(itemId);
    await docRef.delete();
  }
}
