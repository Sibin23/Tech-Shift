import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateCabinet extends StatefulWidget {
  final String itemId;
  const UpdateCabinet({super.key, required this.itemId});

  @override
  State<UpdateCabinet> createState() => _UpdateCabinetState();
}

class _UpdateCabinetState extends State<UpdateCabinet> {
  final _formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  final categoryName = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final topCoolerMax = TextEditingController();
  final topCoolerMin = TextEditingController();
  final _model = TextEditingController();
  final _usb2 = TextEditingController();
  final _usb3 = TextEditingController();
  final _productDimension = TextEditingController();
  final _material = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _fanSize = TextEditingController();
  final _fancount = TextEditingController();
  final _warranty = TextEditingController();
  String? selectedCabinet;
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedCategory;
  // add image
  late String imageurl = '';
  String? image;
  Future<void> pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {});
    }
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('cabinet')
        .doc(widget.itemId) // Use the itemId
        .update({
      'image': imageurl.toString(),
      'name': _productName.text,
      'idnum': idNum.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'topcoolermin': topCoolerMin.text,
      'topcoolermax': topCoolerMax.text,
      'model': _model.text,
      'productdimension': _productDimension.text,
      'material': _material.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'usb2': _usb2.text,
      'usb3': _usb3.text,
      'warranty': _warranty.text,
      'fansize': _fanSize.text,
      'fancount': _fancount.text,
    });
    setState(() {
      imageurl = '';
      _productName.clear();
      categoryName.clear();
      idNum.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      topCoolerMax.clear();
      topCoolerMin.clear();
      _model.clear();
      _productDimension.clear();
      _material.clear();
      _country.clear();
      _itemWeight.clear();
      _usb2.clear();
      _usb3.clear();
      _warranty.clear();
      _fanSize.clear();
      _fancount.clear();
    });
  }

  // add to firefase
  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Cabinet/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('cabinet')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        _productName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        idNum.text = data['idnum'];
        categoryName.text = data['category'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        topCoolerMax.text = data['topcoolermax'];
        topCoolerMin.text = data['topcoolermin'];
        _model.text = data['model'];
        _manufacturer.text = data['manufacturer'];
        _usb2.text = data['usb2'];
        _usb3.text = data['usb3'];
        _fanSize.text = data['fansize'];
        _fancount.text = data['fancount'];
        _productDimension.text = data['productdimension'];
        _material.text = data['material'];
        _country.text = data['country'];
        _itemWeight.text = data['country'];
        _warranty.text = data['warranty'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('cabinet').snapshots(),
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
                final cabinet = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final manufacturer = snapshot.data!.docs
                    .map((doc) => doc['manufacturer'] as String)
                    .toSet()
                    .toList();
                final model = snapshot.data!.docs
                    .map((doc) => doc['model'] as String)
                    .toSet()
                    .toList();

                return SingleChildScrollView(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Text('Cabinet', style: CustomText.title),
                              const SizedBox(height: 20),
                              AdminUiHelper.customImageBox(() {
                                pickImage();
                              }, imageurl: imageurl),
                              const SizedBox(height: 30),
                              Form(
                                  key: _formkey,
                                  child: Column(children: [
                                    AdminUi.admTextField(
                                        label: 'Unique ID',
                                        textcontroller: idNum),
                                    space,
                                    DropdownMenu<String>(
                                        controller: categoryName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Category',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                hintStyle: const TextStyle(
                                                    color:
                                                        CustomColors.appTheme),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
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
                                        controller: _productName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Cabinet',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                hintStyle: const TextStyle(
                                                    color:
                                                        CustomColors.appTheme),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedCabinet = value;
                                          });
                                        },
                                        dropdownMenuEntries: cabinet
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        controller: _manufacturer,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Manufacturer',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                hintStyle: const TextStyle(
                                                    color:
                                                        CustomColors.appTheme),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedManufacturer = value;
                                          });
                                        },
                                        dropdownMenuEntries: manufacturer
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        controller: _model,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Model Name',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                hintStyle: const TextStyle(
                                                    color:
                                                        CustomColors.appTheme),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
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
                                    AdminUi.admTextField(
                                        label: 'Number of ports USB 2.0',
                                        textcontroller: _usb2),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Number of Ports USB 3.0',
                                        textcontroller: _usb3),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Fan Size',
                                        textcontroller: _fanSize),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Fan Count',
                                        textcontroller: _fancount),
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
                                        label:
                                            'Top Cooler Minimum (in Millimeters)',
                                        textcontroller: topCoolerMin),
                                    space,
                                    AdminUi.admTextField(
                                        label:
                                            'Top Cooler Maximum (in Millimeters)',
                                        textcontroller: topCoolerMax),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Product Dimension',
                                        textcontroller: _productDimension),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Material',
                                        textcontroller: _material),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Country',
                                        textcontroller: _country),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Item Weight',
                                        textcontroller: _itemWeight),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Warranty',
                                        textcontroller: _warranty)
                                  ])),
                              const SizedBox(height: 30),
                              AdminUiHelper.customButton(context, () {
                                if (_formkey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  updateData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Updated Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30),
                            ]))));
              })),
    );
  }
}
