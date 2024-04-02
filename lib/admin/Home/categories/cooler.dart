import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ListCooler extends StatefulWidget {
  const ListCooler({super.key});

  @override
  State<ListCooler> createState() => _ListCoolerState();
}

class _ListCoolerState extends State<ListCooler> {
  final category = TextEditingController();
  final _manufacturer = TextEditingController();
  final _productName = TextEditingController();
  final _coolingMethod = TextEditingController();
  final _fans = TextEditingController();
  final _speed = TextEditingController();

  Future submit() async {
    final data = {
      'category': category.text,
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'method': _coolingMethod.text,
      'fans': _fans.text,
      'speed': _speed.text
    };
    FirebaseFirestore.instance
        .collection('coolerdetails')
        .doc(_productName.text)
        .set(data);
    setState(() {
      category.clear();
      _productName.clear();
      _coolingMethod.clear();
      _fans.clear();
      _manufacturer.clear();
      _speed.clear();
    });
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: "Item Added Successfully",
      ),
    );
  }

  Future deleteItem(documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('coolerdetails')
          .doc(documentId)
          .delete();
      deleteMessage();
    } catch (error) {
      // Handle errors gracefully
      errorMessage(error);
    }
  }

  void deleteMessage() {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: "Item Deleted Successfully",
      ),
    );
  }

  void errorMessage(error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error deleting item: $error')),
    );
  }

  void addItem() {
    final formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
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
                              label: 'Cooling Method',
                              textcontroller: _coolingMethod),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Fans', textcontroller: _fans),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Speed', textcontroller: _speed)
                        ],
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel',
                    style: TextStyle(color: CustomColors.appTheme)),
              ),
              TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    submit();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit',
                    style: TextStyle(color: CustomColors.appTheme)),
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
          stream: FirebaseFirestore.instance
              .collection('coolerdetails')
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
                    final document = snapshot.data!.docs[index];
                    final id = document.id;
                    String name = document['name'];
                    return AdminUiHelper.listCard(context, () {
                      deleteItem(id);
                    }, name: name, iconData: Icons.delete);
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
