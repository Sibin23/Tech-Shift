import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class UpdateMonitor extends StatefulWidget {
  final String itemId;
  const UpdateMonitor({super.key, required this.itemId});

  @override
  State<UpdateMonitor> createState() => _UpdateMonitorState();
}

class _UpdateMonitorState extends State<UpdateMonitor> {
  final _formkey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
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

  updateData() {
    FirebaseFirestore.instance.collection('monitor').doc(widget.itemId).update({
      'category': categoryName.text.toLowerCase(),
      'image': imageurl.toString(),
      'idnum': widget.itemId,
      'name': productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
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
        categoryName.text = data['category'];
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
    const space = SizedBox(height: 10);
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
                          space,
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
                          space,
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
                          space,
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
                          space,
                          AdminUi.admTextField(
                              label: 'Old Price', textcontroller: _oldPrice),
                          space,
                          AdminUi.admTextField(
                              label: 'New Price', textcontroller: _newPrice),
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
                              label: 'Resolution', textcontroller: _resolution),
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
                              label: 'Warranty', textcontroller: _warranty),
                          space,
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
