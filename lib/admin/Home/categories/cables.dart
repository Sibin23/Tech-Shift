import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ListCables extends StatefulWidget {
  const ListCables({super.key});

  @override
  State<ListCables> createState() => _ListCablesState();
}

class _ListCablesState extends State<ListCables> {
  final category = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _model = TextEditingController();
  final _speed = TextEditingController();

  Future submit() async {
    final data = {
      'category': category.text,
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'speed': _speed.text,
      'model': _model.text,
    };
    FirebaseFirestore.instance.collection('cabledetails').doc().set(data);
    setState(() {
      category.clear();
      _productName.clear();
      _manufacturer.clear();
      _speed.clear();
      _model.clear();
    });
    success();
  }

  void success() {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: "Item Added Successfully",
      ),
    );
  }

  void errorMessage(error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error deleting item: $error')));
  }

  void deleteMessage() {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: "Item Deleted Successfully",
      ),
    );
  }

  Future deleteItem(documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cabledetails')
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
                              label: 'Product Category',
                              textcontroller: category),
                          AdminUi.space,
                          AdminUi.admTextField(
                              label: 'Product Name',
                              textcontroller: _productName),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Manufacturer',
                              textcontroller: _manufacturer),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Model', textcontroller: _model),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Transfer Rate', textcontroller: _speed),
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
        centerTitle: true,
        backgroundColor: CustomColors.appTheme,
        title: Text(
          'Coolers',
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
          stream:
              FirebaseFirestore.instance.collection('cabledetails').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    // Access the document and the desired field
                    final document = snapshot.data!.docs[index];
                    final id = document.id;
                    String name = document['name'];
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, top: 8, bottom: 8),
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
                                Text(
                                  name,
                                  style: CustomText.title3,
                                ),
                                IconButton(
                                  onPressed: () {
                                    AdminUi.customAlert(() {}, () {
                                      deleteItem(
                                        id,
                                      );
                                    }, context,
                                        text1: 'Cancel', text2: 'Delete');
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
          },
        ),
      ),
    );
  }
}
