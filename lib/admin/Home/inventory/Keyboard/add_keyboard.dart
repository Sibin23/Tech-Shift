import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ScreenAddKeyboard extends StatefulWidget {
  const ScreenAddKeyboard({super.key});

  @override
  State<ScreenAddKeyboard> createState() => _ScreenAddKeyboardState();
}

class _ScreenAddKeyboardState extends State<ScreenAddKeyboard> {
  final _formkey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _productDimension = TextEditingController();
  final _modelName = TextEditingController();
  final _connector = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _material = TextEditingController();
  final _warranty = TextEditingController();
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  bool isNew = false;
  bool isPopular = false;
  late String imageurl = '';
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {});
    }
  }

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Keyboard/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      category: keyboard,
      uniqueId: idnum,
      itemImage: imageurl.toString(),
      name: _productName.text,
      manufacturer: _manufacturer.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      model: _modelName.text,
      dimension: _productDimension.text,
      features: _specialFeatures.text,
      connectivity: _connector.text,
      material: _material.text,
      country: _country.text,
      weight: _itemWeight.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular,
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: keyboard,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(keyboard).doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _modelName.clear();
      _specialFeatures.clear();
      _material.clear();
      _productDimension.clear();
      _connector.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
      isNew = false;
      isPopular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Text('Gaming Keyboard', style: CustomText.title),
                    h30,
                    AdminUiHelper.customImageBox(() {
                      pickImage();
                    }, imageurl: imageurl),
                    h30,
                    Form(
                        key: _formkey,
                        child: Column(children: [
                          AdminUi.admTextField(
                              label: 'Product Name',
                              textcontroller: _productName),
                          h10,
                          AdminUi.admTextField(
                              label: 'Model Name', textcontroller: _modelName),
                          h10,
                          AdminUi.admTextField(
                              label: 'Manufacturer',
                              textcontroller: _manufacturer),
                          h10,
                          AdminUi.admTextField(
                              label: 'Old Price', textcontroller: _oldPrice),
                          h10,
                          AdminUi.admTextField(
                              label: 'New Price', textcontroller: _newPrice),
                          h10,
                          AdminUi.admTextField(
                              label: 'Product Dimensions',
                              textcontroller: _productDimension),
                          h10,
                          AdminUi.featuresTextfield(
                              label: 'Features',
                              textcontroller: _specialFeatures),
                          h10,
                          AdminUi.admTextField(
                              label: 'Connectivity',
                              textcontroller: _connector),
                          h10,
                          AdminUi.admTextField(
                              label: 'Material', textcontroller: _material),
                          h10,
                          AdminUi.admTextField(
                              label: 'Country', textcontroller: _country),
                          h10,
                          AdminUi.admTextField(
                              label: 'Item Weight',
                              textcontroller: _itemWeight),
                          h10,
                          AdminUi.admTextField(
                              label: 'Warranty', textcontroller: _warranty),
                          h10,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(children: [
                                  Checkbox(
                                      tristate: false,
                                      activeColor: CustomColors.appTheme,
                                      value: isNew,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isNew = newValue!;
                                        });
                                      }),
                                  Text('New Arrival',
                                      style: CustomText.categoryTitleText)
                                ]),
                                Row(children: [
                                  Checkbox(
                                      tristate: false,
                                      activeColor: CustomColors.appTheme,
                                      value: isPopular,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isPopular = newValue!;
                                        });
                                      }),
                                  Text('Popular Item',
                                      style: CustomText.categoryTitleText)
                                ])
                              ])
                        ])),
                    h30,
                    AdminUiHelper.customButton(context, () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.pop(context);
                        submitData();
                        AdminUiHelper.customSnackbar(
                            context, 'Item Added Successfully !');
                      }
                    }, text: 'Save'),
                    h30
                  ])))),
    );
  }
}
