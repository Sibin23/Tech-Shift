// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ListMotherboard extends StatefulWidget {
  const ListMotherboard({super.key});

  @override
  State<ListMotherboard> createState() => _ListMotherboardState();
}

class _ListMotherboardState extends State<ListMotherboard> {
  final categoryName = TextEditingController();
  final productName = TextEditingController();
  final model = TextEditingController();
  final clockSpeed = TextEditingController();
  final socket = TextEditingController();
  final manufacturer = TextEditingController();
  final ramType = TextEditingController();
  final ssdType = TextEditingController();

  Future submit() async {
    final data = {
      'category': categoryName.text.trim().toLowerCase(),
      'name': productName.text,
      'model': model.text,
      'manufacturer': manufacturer.text,
      'maxclockspeed': clockSpeed.text,
      'socket': socket.text,
      'ram': ramType.text.trim().toUpperCase(),
      'ssd': ssdType.text,
    };
    FirebaseFirestore.instance.collection('motherboarddetails').doc().set(data);
    setState(() {
      categoryName.clear();
      productName.clear();
      model.clear();
      manufacturer.clear();
      clockSpeed.clear();
      ramType.clear();
      socket.clear();
      ssdType.clear();
    });
    showTopSnackBar(Overlay.of(context),
        const CustomSnackBar.success(message: "Item Added Successfully"));
  }

  Future deleteItem(documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('motherboarddetails')
          .doc(documentId)
          .delete();
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: "Item Deleted Successfully"));
    } catch (error) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting item: $error')));
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
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Product Category',
                              textcontroller: categoryName),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Product Name',
                              textcontroller: productName),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Model Name', textcontroller: model),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Manufacturer',
                              textcontroller: manufacturer),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Socket Type', textcontroller: socket),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Ram Type', textcontroller: ramType),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Max Clock Speed',
                              textcontroller: clockSpeed),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'SSD Type', textcontroller: ssdType),
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
          'Motherboards',
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
              .collection('motherboarddetails')
              .snapshots(),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: CustomText.title3,
                                  ),
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
