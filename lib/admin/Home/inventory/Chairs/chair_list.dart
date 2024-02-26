import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/Chairs/add_chair.dart';
import 'package:prosample_1/admin/Home/inventory/Chairs/update_chair.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ChairDetails extends StatefulWidget {
  const ChairDetails({super.key});

  @override
  State<ChairDetails> createState() => _ChairDetailsState();
}

class _ChairDetailsState extends State<ChairDetails> {
  Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('chair').doc(itemId);
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
                          builder: (ctx) => const ScreenAddChairs()));
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
                  .collection('chairs')
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
                                      UpdateChair(itemId: itemId)));
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