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

class ScreenAddMonitor extends StatefulWidget {
  const ScreenAddMonitor({super.key});

  @override
  State<ScreenAddMonitor> createState() => _ScreenAddMonitorState();
}

class _ScreenAddMonitorState extends State<ScreenAddMonitor> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _modelName = TextEditingController();
  final _productDimension = TextEditingController();
  final _veiwingAngle = TextEditingController();
  final _displayType = TextEditingController();
  final _displaySize = TextEditingController();
  final _responseTime = TextEditingController();
  final _resolution = TextEditingController();
  final _refreshRate = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _voltage = TextEditingController();
  final _hdwInterface = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  late String imageurl = '';
  bool isNew = false;
  bool isPopular = false;
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
        FirebaseStorage.instance.ref().child('Monitor/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  Future submitData() async {
    final data = {
      category: monitor,
      itemImage: imageurl.toString(),
      uniqueId: idnum,
      name: _productName.text,
      manufacturer: _manufacturer.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      model: _modelName.text,
      dimension: _productDimension.text,
      viewAngle: _veiwingAngle.text,
      displayType: _displayType.text,
      displaySize: _displaySize.text,
      response: _responseTime.text,
      resolution: _resolution.text,
      refRate: _refreshRate.text,
      features: _specialFeatures.text,
      voltage: _voltage.text,
      hdwinterface: _hdwInterface.text,
      country: _country.text,
      weight: _itemWeight.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: monitor,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(monitor).doc(idnum).set(data);
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _modelName.clear();
      _productDimension.clear();
      _veiwingAngle.clear();
      _displayType.clear();
      _displaySize.clear();
      _responseTime.clear();
      _resolution.clear();
      _refreshRate.clear();
      _specialFeatures.clear();
      _voltage.clear();
      _hdwInterface.clear();
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
                    Text('Add Monitor', style: CustomText.title),
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
                          AdminUi.admTextField(
                              label: 'Viewing Angle',
                              textcontroller: _veiwingAngle),
                          h10,
                          AdminUi.admTextField(
                              label: 'Display Type',
                              textcontroller: _displayType),
                          h10,
                          AdminUi.admTextField(
                              label: 'Display Size',
                              textcontroller: _displaySize),
                          h10,
                          AdminUi.admTextField(
                              label: 'Response Time',
                              textcontroller: _responseTime),
                          h10,
                          AdminUi.admTextField(
                              label: 'Resolution', textcontroller: _resolution),
                          h10,
                          AdminUi.admTextField(
                              label: 'Refresh Rate',
                              textcontroller: _refreshRate),
                          h10,
                          AdminUi.admTextField(
                              label: 'Features',
                              textcontroller: _specialFeatures),
                          h10,
                          AdminUi.admTextField(
                              label: 'Voltage', textcontroller: _voltage),
                          h10,
                          AdminUi.admTextField(
                              label: 'Hardware Interface',
                              textcontroller: _hdwInterface),
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
