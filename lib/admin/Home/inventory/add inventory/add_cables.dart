import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddCables extends StatefulWidget {
  const ScreenAddCables({super.key});

  @override
  State<ScreenAddCables> createState() => _ScreenAddCablesState();
}

class _ScreenAddCablesState extends State<ScreenAddCables> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _connectorType = TextEditingController();
  final _color = TextEditingController();
  final _pinNumbers = TextEditingController();
  final _itemWeight = TextEditingController();
  final _model = TextEditingController();
  final _modelName = TextEditingController();
  final _wattage = TextEditingController();
  final _voltage = TextEditingController();
  final _productDimension = TextEditingController();
  final _country = TextEditingController();
  late String imageurl = '';
  Future<void> pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {});
    }
  }

  // add to firefase
  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Cables/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'categoryid': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'connector': _connectorType.text,
      'color': _color.text,
      'pins': _pinNumbers.text,
      'model': _model.text,
      'modelname': _modelName.text,
      'wattage': _wattage.text,
      'voltage': _voltage.text,
      'productdimension': _productDimension.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'newarrival': newArival,
    };
    FirebaseFirestore.instance
        .collection('cables')
        .doc(_productCategory.text.toLowerCase())
        .set(data);
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _connectorType.clear();
      _color.clear();
      _pinNumbers.clear();
      _model.clear();
      _modelName.clear();
      _wattage.clear();
      _voltage.clear();
      _productDimension.clear();
      _itemWeight.clear();
      _country.clear();
      _itemWeight.clear();
      newArival = false;
    });
  }

  static bool newArival = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text('Cables', style: CustomText.title),
                        const SizedBox(height: 20),
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        const SizedBox(height: 20),
                        Form(
                            key: _formkey,
                            child: Column(children: [
                              AdminUi.admTextField(
                                  label: 'Category Name',
                                  textcontroller: _productCategory),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Brand', textcontroller: _productName),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Manufacturer',
                                  textcontroller: _manufacturer),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Old Price', textcontroller: _oldPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'New Price', textcontroller: _newPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Connector Type',
                                  textcontroller: _connectorType),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Colour', textcontroller: _color),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Number of Pins',
                                  textcontroller: _pinNumbers),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Model Number', textcontroller: _model),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Model Name',
                                  textcontroller: _modelName),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Wattage', textcontroller: _wattage),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Voltage', textcontroller: _voltage),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Product Dimenstions',
                                  textcontroller: _productDimension),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _itemWeight),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                            ])),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              value: newArival,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  newArival = value!;
                                                });
                                              }),
                                          Text('New Arrival',
                                              style: CustomText.title3)
                                        ])
                                  ])),
                        AdminUiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            submitData();
                            AdminUiHelper.customSnackbar(context, 'Item Added Successfully !');
                          }
                        }, text: 'Save'),
                        const SizedBox(height: 30),
                      ]))))),
    );
  }
}
