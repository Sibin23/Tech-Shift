import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/pc%20builds/prebuild.dart';
import 'package:prosample_1/admin/pc%20builds/update_textfield.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

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
        title: Text('List Pre-Builds',style: CustomText.apptitle),
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ScreenPreBuild()));
            }, icon: Image.asset('assets/icons/add.png',width: 30,color: Colors.white)),
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
                                print(itemId);
                            
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
                            Navigator.pop(context);
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
