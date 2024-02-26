import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/Cabinet/add_cabinet.dart';
import 'package:prosample_1/admin/Home/inventory/Cabinet/update_cabinet.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class CabinetDetails extends StatefulWidget {
  const CabinetDetails({super.key});

  @override
  State<CabinetDetails> createState() => _CabinetDetailsState();
}

class _CabinetDetailsState extends State<CabinetDetails> {
   Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('cabinet').doc(itemId);
    await docRef.delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text('Processor Details', style: CustomText.apptitle),
        backgroundColor: CustomColors.appTheme,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const ScreenAddCabinet()));
                },
                icon: Image.asset('assets/icons/add.png',
                    width: 30, color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(child: SizedBox(
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
                      String name = document['name'];
                      String itemId = document.id;

                      return AdminUiHelper.updatelist(context, () {
                        AdminUi.customAlert(text1: 'Edit', text2: 'Delete', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      UpdateCabinet(itemId: itemId)));
                        }, () {
                          deleteData(itemId);
                          AdminUiHelper.customSnackbar(
                              context, 'Item Deleted Successfully !');
                        }, context);
                      }, imageUrl: imageUrl, categoryName: name);
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: CustomColors.appTheme));
                }
              },
            )),
      ),
    );
  }
}