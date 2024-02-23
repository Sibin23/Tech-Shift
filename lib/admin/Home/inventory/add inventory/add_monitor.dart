import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

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
  static bool newArival = false;
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

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Monitor/${image.name}');
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
      'modelname': _modelName.text,
      'productdimension': _productDimension.text,
      'viewingangle': _veiwingAngle.text,
      'displaytype': _displayType.text,
      'displaysize': _displaySize.text,
      'response': _responseTime.text,
      'resolution': _resolution.text,
      'refRate': _refreshRate.text,
      'features': _specialFeatures.text,
      'voltage': _voltage.text,
      'hdwinterface': _hdwInterface.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
      'newarrival': newArival,
    };
    FirebaseFirestore.instance
        .collection('monitor')
        .doc(_productCategory.text.toLowerCase())
        .set(data);
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
      newArival = false;
    });
  }

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
                        Text('Monitor', style: CustomText.title),
                        const SizedBox(height: 20),
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        const SizedBox(height: 20),
                        Form(
                            child: Column(children: [
                          AdminUi.admTextField(
                              label: 'Category Name',
                              textcontroller: _productCategory),
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
                              label: 'Old Price', textcontroller: _oldPrice),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'New Price', textcontroller: _newPrice),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Model Name', textcontroller: _modelName),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Product Dimensions',
                              textcontroller: _productDimension),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Viewing Angle',
                              textcontroller: _veiwingAngle),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Display Type',
                              textcontroller: _displayType),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Display Size',
                              textcontroller: _displaySize),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Response Time',
                              textcontroller: _responseTime),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Resolution', textcontroller: _resolution),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Refresh Rate',
                              textcontroller: _refreshRate),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Features',
                              textcontroller: _specialFeatures),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Voltage', textcontroller: _voltage),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Hardware Interface',
                              textcontroller: _hdwInterface),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Country', textcontroller: _country),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Item Weight', textcontroller: _itemWeight),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(label: 'Warranty',textcontroller: _warranty),
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
                                  ]))
                        ])), // textformfield
                         AdminUiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            submitData();
                            AdminUiHelper.customSnackbar(
                                context, 'Item Added Successfully !');
                          }
                        }, text: 'Save'),
                        const SizedBox(height: 30)
                      ]))))),
    );
  }
}
