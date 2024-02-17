import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';

import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  final TextEditingController _textController = TextEditingController();
  final _idController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future submitData() async {
    final data = {
      'categoryid': _idController.text..trim().toLowerCase(),
      'name': _textController.text,
    };
    FirebaseFirestore.instance.collection('category').doc().set(data);

    setState(() {
      _textController.clear();
      _idController.clear();
    });
  }

  // Update Category
  Future updateCategory(categoryId) async {
    final updateId = {
      'categoryid': categoryId['categoryid'],
      'name': categoryId['name'],
    };
    setState(() {
      _textController.text = updateId['name'];

      _idController.text = updateId['categoryid'];
    });
    FirebaseFirestore.instance.collection('category').doc();
  }

  // Delete Category
  Future deleteCategory(document) async {
    FirebaseFirestore.instance.collection('categoryid').doc(document).delete();
    // Reference to the specific document (obtain it earlier)
  }

  List<String> names = [
    "cooler",
    "cables",
    "cabinet",
    "chairs",
    "headsets",
    "keyboard",
    "mouse",
    "monitor",
    "motherboard",
    "psu",
    "processor",
    "ram",
    "ssd"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        centerTitle: true,
        title: Text(
          'Add Category ID',
          style: CustomText.apptitle,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        AdminUi.admTextField(
                            label: 'Category name',
                            textcontroller: _idController),
                        const SizedBox(height: 20.0),
                        AdminUi.admTextField(
                            label: 'Product Name',
                            textcontroller: _textController),
                        const SizedBox(height: 20.0),
                      ],
                    )),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: AdminUi.customButton(context, formkey: _formkey,
                      voidCallback: () {
                    if (_formkey.currentState!.validate()) {
                      submitData();
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.success(
                          message: "Item Added Successfully",
                        ),
                      );
                    }
                  }, text: 'Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
