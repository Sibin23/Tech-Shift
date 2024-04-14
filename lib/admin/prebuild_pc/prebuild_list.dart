import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/prebuild_pc/prebuild_pc_add.dart';
import 'package:prosample_1/admin/prebuild_pc/prebuild_pc_update.dart';
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
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(admBoxImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
                icon: Image.asset(add, width: 30, color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(preBuild)
            .orderBy(name)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                final item = document.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      AdminUi.customAlert(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    EditPC(id: item[uniqueId], item: item)));
                      }, () {
                        deleteData(item[uniqueId]);
                        AdminUiHelper.customSnackbar(
                            context, 'Item Deleted Successfully !');
                      }, context, text1: 'Edit', text2: 'Delete');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Text('Please Update Image'),
                                    ),
                                imageUrl: item[itemImage],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item[uniqueId],
                                      style: CustomText.categoryText),
                                  Text(item[cabinet],
                                      style: CustomText.categoryText),
                                  Text(item[category],
                                      style: CustomText.categoryText),
                                  Row(
                                    children: [
                                      const Text(
                                        ' ₹ ',
                                      ),
                                      Text(item[oldPrice],
                                          style: CustomText.lineThrough),
                                      const SizedBox(width: 10),
                                      Text(' ₹ ${item[oldPrice]}',
                                          style: CustomText.subtitleG)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }

  Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection(preBuild).doc(itemId);
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
}
