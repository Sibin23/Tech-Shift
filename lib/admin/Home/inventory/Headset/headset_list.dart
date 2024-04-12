import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/home/inventory/Headset/add_headset.dart';
import 'package:prosample_1/admin/home/inventory/Headset/update_headset.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class HeadsetDetails extends StatefulWidget {
  const HeadsetDetails({super.key});

  @override
  State<HeadsetDetails> createState() => _HeadsetDetailsState();
}

class _HeadsetDetailsState extends State<HeadsetDetails> {
  Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection(headset).doc(itemId);
    await docRef.delete();
    deleteNewArivals(itemId);
    deletePopular(itemId);
  }

  Future<void> deleteNewArivals(String itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection(newArival).doc(itemId);
    await docRef.delete();
  }

  Future<void> deletePopular(String itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection(popular).doc(itemId);
    await docRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Headset Details', style: CustomText.apptitle),
        backgroundColor: CustomColors.appTheme,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const ScreenAddHeadset()));
                },
                icon: Image.asset(add, width: 30,color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(headset)
                  .orderBy(name)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(child: Text('No Items Yet')),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      Map<String, dynamic> item =
                          document.data() as Map<String, dynamic>;

                      return AdminUiHelper.updatelist(context, () {
                        AdminUi.customAlert(text1: 'Edit', text2: 'Delete', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => UpdateHeadset(
                                      item: item, id: item[uniqueId])));
                        }, () {
                          deleteData(item[uniqueId]);
                          AdminUiHelper.customSnackbar(
                              context, 'Item Deleted Successfully !');
                        }, context);
                      }, imageUrl: item[itemImage], categoryName: item[name]);
                    },
                  );
                }
                return const Center(
                    child: CircularProgressIndicator(
                        color: CustomColors.appTheme));
              })),
    );
  }
}
