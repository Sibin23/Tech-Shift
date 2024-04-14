import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  Future<void> updateCollectionAndRemoveNewArrival(
      String collection, String idnum) async {
    final firestore = FirebaseFirestore.instance;
    final targetDocRef = firestore.collection(collection).doc(idnum);
    await targetDocRef.update({
      popular: false,
    });
    final newArrivalDocRef = firestore.collection(popular).doc(idnum);
    await newArrivalDocRef.delete();
  }

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
        title: const Text('Popular Items'),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(popular)
                  .orderBy(uniqueId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: Text("No Items Yet")));
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return AdminUiHelper.updatelist(context, () {
                          AdminUi.customAlert(() {}, () {
                            updateCollectionAndRemoveNewArrival(
                                data[category], data[uniqueId]);
                          }, context, text1: 'Cancel', text2: 'Delete');
                        }, imageUrl: data[itemImage], categoryName: data[name]);
                      });
                }
                return const Text('Loading');
              })),
    );
  }
}
