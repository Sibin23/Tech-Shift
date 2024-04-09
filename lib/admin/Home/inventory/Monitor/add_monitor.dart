import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String? selectedCategory;
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedMonitor;
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
      'category': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'idnum': idnum,
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'model': _modelName.text,
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
    };
    FirebaseFirestore.instance.collection('monitor').doc(idnum).set(data);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('monitordetails')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final category = snapshot.data!.docs
                        .map((doc) => doc['category'] as String)
                        .toSet()
                        .toList();
                    final monitor = snapshot.data!.docs
                        .map((doc) => doc['name'] as String)
                        .toSet()
                        .toList();
                    final model = snapshot.data!.docs
                        .map((doc) => doc['model'] as String)
                        .toSet()
                        .toList();
                    final manufactured = snapshot.data!.docs
                        .map((doc) => doc['manufacturer'] as String)
                        .toSet()
                        .toList();
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text('Monitor', style: CustomText.title),
                          const SizedBox(height: 20),
                          AdminUiHelper.customImageBox(() {
                            pickImage();
                          }, imageurl: imageurl),
                          const SizedBox(height: 20),
                          Form(
                              key: _formkey,
                              child: Column(children: [
                                DropdownMenu<String>(
                                    label: const Text('Select Category',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: _productCategory,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                    },
                                    dropdownMenuEntries: category
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                space,
                                DropdownMenu<String>(
                                    label: const Text('Select Monitor',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: _productName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedMonitor = value;
                                      });
                                    },
                                    dropdownMenuEntries: monitor
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                space,
                                DropdownMenu<String>(
                                    label: const Text('Select Model',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: _modelName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedModel = value;
                                      });
                                    },
                                    dropdownMenuEntries: model
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                space,
                                DropdownMenu<String>(
                                    label: const Text('Select Manufacturer',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: _manufacturer,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedManufacturer = value;
                                      });
                                    },
                                    dropdownMenuEntries: manufactured
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                space,
                                AdminUi.admTextField(
                                    label: 'Old Price',
                                    textcontroller: _oldPrice),
                                space,
                                AdminUi.admTextField(
                                    label: 'New Price',
                                    textcontroller: _newPrice),
                                space,
                                AdminUi.admTextField(
                                    label: 'Product Dimensions',
                                    textcontroller: _productDimension),
                                space,
                                AdminUi.admTextField(
                                    label: 'Viewing Angle',
                                    textcontroller: _veiwingAngle),
                                space,
                                AdminUi.admTextField(
                                    label: 'Display Type',
                                    textcontroller: _displayType),
                                space,
                                AdminUi.admTextField(
                                    label: 'Display Size',
                                    textcontroller: _displaySize),
                                space,
                                AdminUi.admTextField(
                                    label: 'Response Time',
                                    textcontroller: _responseTime),
                                space,
                                AdminUi.admTextField(
                                    label: 'Resolution',
                                    textcontroller: _resolution),
                                space,
                                AdminUi.admTextField(
                                    label: 'Refresh Rate',
                                    textcontroller: _refreshRate),
                                space,
                                AdminUi.admTextField(
                                    label: 'Features',
                                    textcontroller: _specialFeatures),
                                space,
                                AdminUi.admTextField(
                                    label: 'Voltage', textcontroller: _voltage),
                                space,
                                AdminUi.admTextField(
                                    label: 'Hardware Interface',
                                    textcontroller: _hdwInterface),
                                space,
                                AdminUi.admTextField(
                                    label: 'Country', textcontroller: _country),
                                space,
                                AdminUi.admTextField(
                                    label: 'Item Weight',
                                    textcontroller: _itemWeight),
                                space,
                                AdminUi.admTextField(
                                    label: 'Warranty',
                                    textcontroller: _warranty),
                                space,
                              ])),
                          const SizedBox(height: 30),
                          AdminUiHelper.customButton(context, () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.pop(context);
                              submitData();
                              AdminUiHelper.customSnackbar(
                                  context, 'Item Added Successfully !');
                            }
                          }, text: 'Save'),
                          const SizedBox(height: 30)
                        ]));
                  }))),
    );
  }
}
