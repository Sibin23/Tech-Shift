import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateMonitor extends StatefulWidget {
  final String itemId;
  const UpdateMonitor({super.key, required this.itemId});

  @override
  State<UpdateMonitor> createState() => _UpdateMonitorState();
}

class _UpdateMonitorState extends State<UpdateMonitor> {
  final _formkey = GlobalKey<FormState>();

  final idNum = TextEditingController();
  final categoryName = TextEditingController();
  final _series = TextEditingController();
  final productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final modelName = TextEditingController();
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
  String? image;
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

  updateData() {
    FirebaseFirestore.instance
        .collection('monitor')
        .doc(widget.itemId) // Use the itemId
        .update({
      'category': categoryName.text.toLowerCase(),
      'image': imageurl.toString(),
      'idnum': idNum.text,
      'name': productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'series': _series.text,
      'model': modelName.text,
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
    });
    setState(() {
      categoryName.clear();
      imageurl = '';
      idNum.clear();
      _series.clear();
      productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      modelName.clear();
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
  void initState() {
    print(widget.itemId);
    FirebaseFirestore.instance
        .collection('monitor')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        productName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        idNum.text = data['idnum'];
        categoryName.text = data['category'];
        _series.text = data['series'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        modelName.text = data['model'];
        _manufacturer.text = data['manufacturer'];
        _productDimension.text = data['productdimension'];
        _veiwingAngle.text = data['viewingangle'];
        _displaySize.text = data['displaysize'];
        _displayType.text = data['displaytype'];
        _resolution.text = data['resolution'];
        _responseTime.text = data['response'];
        _refreshRate.text = data['refRate'];
        _specialFeatures.text = data['features'];
        _voltage.text = data['voltage'];
        _hdwInterface.text = data['hdwinterface'];
        _country.text = data['country'];
        _itemWeight.text = data['itemweight'];
        _warranty.text = data['warranty'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('mouse').snapshots(),
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
                          AdminUi.admTextField(
                              label: 'Unique ID', textcontroller: idNum),
                          const SizedBox(height: 10),
                          DropdownMenu<String>(
                              label: const Text('Select Category',
                                  style:
                                      TextStyle(color: CustomColors.appTheme)),
                              controller: categoryName,
                              menuStyle: const MenuStyle(
                                  surfaceTintColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              width: MediaQuery.of(context).size.width * .93,
                              menuHeight: 300,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
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
                          const SizedBox(height: 10),
                          DropdownMenu<String>(
                              label: const Text('Select Monitor',
                                  style:
                                      TextStyle(color: CustomColors.appTheme)),
                              controller: productName,
                              menuStyle: const MenuStyle(
                                  surfaceTintColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              width: MediaQuery.of(context).size.width * .93,
                              menuHeight: 300,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
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
                          const SizedBox(height: 10),
                          DropdownMenu<String>(
                              label: const Text('Select Model',
                                  style:
                                      TextStyle(color: CustomColors.appTheme)),
                              controller: modelName,
                              menuStyle: const MenuStyle(
                                  surfaceTintColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              width: MediaQuery.of(context).size.width * .93,
                              menuHeight: 300,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
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
                          const SizedBox(height: 10),
                          DropdownMenu<String>(
                              label: const Text('Select Manufacturer',
                                  style:
                                      TextStyle(color: CustomColors.appTheme)),
                              controller: _manufacturer,
                              menuStyle: const MenuStyle(
                                  surfaceTintColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              width: MediaQuery.of(context).size.width * .93,
                              menuHeight: 300,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
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
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Series', textcontroller: _series),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Old Price', textcontroller: _oldPrice),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'New Price', textcontroller: _newPrice),
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
                              label: 'Item Weight',
                              textcontroller: _itemWeight),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Warranty', textcontroller: _warranty),
                          const SizedBox(height: 10),
                        ])),
                    const SizedBox(height: 30),
                    AdminUiHelper.customButton(context, () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.pop(context);
                        updateData();
                        AdminUiHelper.customSnackbar(
                            context, 'Item Deleted Successfully !');
                      }
                    }, text: 'Save'),
                    const SizedBox(height: 30)
                  ]));
            }),
      )),
    );
  }
}
