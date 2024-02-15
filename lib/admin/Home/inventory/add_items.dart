import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/add_items_details.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenInventory extends StatefulWidget {
  const ScreenInventory({super.key});

  @override
  State<ScreenInventory> createState() => _ScreenInventoryState();
}

class _ScreenInventoryState extends State<ScreenInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appTheme,
          centerTitle: true,
          title: Text("Select Category", style: CustomText.apptitle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('admin')
                            .orderBy('name')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                // ignore: unused_local_variable
                                String imageUrl = document['image'];
                                String categoryName = document['name'];
                                // String categoryid = document['categoryid'];
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx2) =>
                                                    const ScreenItemDetails()));
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                )),
                                            Text(
                                              categoryName,
                                              style:
                                                  CustomText.categoryTitleText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
