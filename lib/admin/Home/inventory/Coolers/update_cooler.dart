import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class EditCooler extends StatefulWidget {
 final String itemId;
  const EditCooler({super.key, required this.itemId});

  @override
  State<EditCooler> createState() => _EditCoolerState();
}

class _EditCoolerState extends State<EditCooler> {
  final _formkey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _connector = TextEditingController();
  final _voltage = TextEditingController();
  final _wattage = TextEditingController();
  final _coolingMethod = TextEditingController();
  final _fans = TextEditingController();
  final _speed = TextEditingController();
  final _noiseLevel = TextEditingController();
  final _warranty = TextEditingController();
  final _productDimension = TextEditingController();
  final _material = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  late String imageurl = '';
  String image = '';
  String? selectedCooler;
  String? selectedFans;
  String? selectedManufacturer;
  String? selectedMethod;
  String? selectedSpeed;
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
        FirebaseStorage.instance.ref().child('Coolers/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('cooler')
        .doc(widget.itemId) // Use the itemId
        .update({
      'image': imageurl.toString(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'connectivity': _connector.text,
      'voltage': _voltage.text,
      'wattage': _wattage.text,
      'cooling': _coolingMethod.text,
      'fans': _fans.text,
      'noise': _noiseLevel.text,
      'productdimension': _productDimension.text,
      'material': _material.text,
      'speed': _speed.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    });
    setState(() {
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _connector.clear();
      _voltage.clear();
      _wattage.clear();
      _fans.clear();
      _coolingMethod.clear();
      _noiseLevel.clear();
      _productDimension.clear();
      _material.clear();
      _speed.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
    });
  }
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('cooler')
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
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _manufacturer.text = data['manufacturer'];
        _connector.text = data['connectivity'];
        _voltage.text = data['voltage'];
        _wattage.text = data['wattage'];
        _speed.text = data['speed'];
        _fans.text = data['fans'];
        _coolingMethod.text = data['cooling'];
        _noiseLevel.text = data['noise'];
        _productDimension.text = data['productdimension'];
        _material.text = data['material'];
        _speed.text = data['speed'];
        _itemWeight.text = data['itemweight'];
        _country.text = data['country'];
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
        child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('coolerdetails')
                  .snapshots(),
              builder: (context, snapshot) {
                 if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
                final cooler = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final manufacturer = snapshot.data!.docs
                    .map((doc) => doc['manufacturer'] as String)
                    .toSet()
                    .toList();
                final method = snapshot.data!.docs
                    .map((doc) => doc['method'] as String)
                    .toSet()
                    .toList();
                final fans = snapshot.data!.docs
                    .map((doc) => doc['fans'] as String)
                    .toSet()
                    .toList();
                final speeds = snapshot.data!.docs
                    .map((doc) => doc['speed'] as String)
                    .toSet()
                    .toList();
                return SingleChildScrollView(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Text('Add Coolers', style: CustomText.title),
                              const SizedBox(height: 20),
                              AdminUiHelper.customImageBox(() {
                                pickImage();
                              }, imageurl: imageurl),
                              const SizedBox(height: 20),
                              Form(
                                  key: _formkey,
                                  child: Column(children: [
                                    DropdownMenu<String>(
                                        controller: _productName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Cooler',
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
                                            selectedCooler = value;
                                          });
                                        },
                                        dropdownMenuEntries: cooler
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    const SizedBox(height: 10),
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
                                    const SizedBox(height: 10),
                                    DropdownMenu<String>(
                                        controller: _coolingMethod,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Cooling Method',
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
                                            selectedMethod = value;
                                          });
                                        },
                                        dropdownMenuEntries: method
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    const SizedBox(height: 10),
                                    DropdownMenu<String>(
                                        controller: _speed,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Speed',
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
                                            selectedSpeed = value;
                                          });
                                        },
                                        dropdownMenuEntries: speeds
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    const SizedBox(height: 10),
                                    DropdownMenu<String>(
                                        controller: _fans,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Fans',
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
                                            selectedFans = value;
                                          });
                                        },
                                        dropdownMenuEntries: fans
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Old Price',
                                        textcontroller: _oldPrice),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'New Price',
                                        textcontroller: _newPrice),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Connector Type',
                                        textcontroller: _connector),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Voltage',
                                        textcontroller: _voltage),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Wattage',
                                        textcontroller: _wattage),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Noise Level',
                                        textcontroller: _noiseLevel),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Product Dimensions',
                                        textcontroller: _productDimension),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Material',
                                        textcontroller: _material),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Country',
                                        textcontroller: _country),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Item Weight',
                                        textcontroller: _itemWeight),
                                    const SizedBox(height: 10),
                                    AdminUi.admTextField(
                                        label: 'Warranty',
                                        textcontroller: _warranty)
                                  ])),
                              const SizedBox(height: 30),
                              AdminUiHelper.customButton(context, () {
                                if (_formkey.currentState!.validate()) {
                                  updateData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Added Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30)
                            ]))));
              })
      ),
    );
  }
}