import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../utils/utils_widget2.dart';

class ListCabinet extends StatefulWidget {
  const ListCabinet({super.key});

  @override
  State<ListCabinet> createState() => _ListCabinetState();
}

class _ListCabinetState extends State<ListCabinet> {
  final categoryName = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _model = TextEditingController();

  Future submit() async {
    final data = {
      'category': categoryName.text.trim().toLowerCase(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'model': _model.text,
    };
    FirebaseFirestore.instance.collection('cabinetdetails').doc().set(data);
    setState(() {
      categoryName.clear();
      _productName.clear();
      _manufacturer.clear();
      _model.clear();
    });
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: "Item Added Successfully",
      ),
    );
  }

  void deleteMessage() {
    showTopSnackBar(Overlay.of(context),
        const CustomSnackBar.error(message: "Item Deleted Successfully"));
  }

  void errorMessage(error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error deleting item: $error')));
  }

  Future deleteItem(documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cabinetdetails')
          .doc(documentId)
          .delete();
      deleteMessage();
    } catch (error) {
      errorMessage(error);
    }
  }

  void addItem() {
    final formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Details'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          AdminUi.admTextField(
                              label: 'Category Name',
                              textcontroller: categoryName),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Product Name',
                              textcontroller: _productName),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Manufacturer',
                              textcontroller: _manufacturer),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Model Name', textcontroller: _model)
                        ],
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    submit();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        title: Text(
          'Cabinet',
          style: CustomText.apptitle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                addItem();
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cabinetdetails')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.data?.docs.isEmpty ?? true) {
              return const Center(child: Text('No Items'));
            }

            final documents = snapshot.data!.docs;
            if (documents.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  final document = snapshot.data!.docs[index];
                  final id = document.id;
                  String name = document['name'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              offset: Offset(3.0, 3.0),
                            )
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  name,
                                  style: CustomText.title3,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  AdminUi.customAlert(() {}, () {
                                    deleteItem(
                                      id,
                                    );
                                  }, context, text1: 'Cancel', text2: 'Delete');
                                },
                                icon: const Icon(Icons.delete),
                                color: CustomColors.appTheme,
                              )
                            ],
                          ),
                        )),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}