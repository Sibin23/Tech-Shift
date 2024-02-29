import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/Headset/add_headset.dart';
import 'package:prosample_1/admin/Home/inventory/Headset/update_headset.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class HeadsetDetails extends StatefulWidget {
  const HeadsetDetails({super.key});

  @override
  State<HeadsetDetails> createState() => _HeadsetDetailsState();
}

class _HeadsetDetailsState extends State<HeadsetDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Headset Details', style: CustomText.apptitle),
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
                          builder: (ctx) => const ScreenAddHeadset()));
                },
                icon: Image.asset('assets/icons/add.png',
                    width: 30, color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('headsets')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      String itemId = document.id;
                      String imageUrl = document['image'];
                      String categoryName = document['name'];

                      return AdminUiHelper.updatelist(context, () {
                        AdminUi.customAlert(text1: 'Edit', text2: 'Delete', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => UpdateHeadset(
                                        itemId: itemId,
                                      )));
                        }, () {
                          
                          AdminUiHelper.customSnackbar(
                              context, 'Item Deleted Successfully !');
                          Navigator.pop(context);
                        }, context);
                      }, imageUrl: imageUrl, categoryName: categoryName);
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