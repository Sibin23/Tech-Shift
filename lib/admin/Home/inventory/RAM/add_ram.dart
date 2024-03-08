import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddRam extends StatefulWidget {
  const ScreenAddRam({super.key});

  @override
  State<ScreenAddRam> createState() => _ScreenAddRamState();
}

class _ScreenAddRamState extends State<ScreenAddRam> {
  final _formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _modelName = TextEditingController();
  final _productDimension = TextEditingController();
  final _ramSize = TextEditingController();
  final _ramType = TextEditingController();
  final _clockSpeed = TextEditingController();
  final _voltage = TextEditingController();
  final _fromFactor = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
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
        FirebaseStorage.instance.ref().child('RAM/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'idnum': idNum.text.trim(),
      'category': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'model': _modelName.text,
      'productdimension': _productDimension.text,
      'ramsize': _ramSize.text,
      'ramtype': _ramType.text,
      'clockspeed': _clockSpeed.text,
      'voltage': _voltage.text,
      'formfactor': _fromFactor.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    };
    FirebaseFirestore.instance
        .collection('ram')
        .doc(idNum.text.toLowerCase())
        .set(data);
    setState(() {
      _productCategory.clear();
      idNum.clear();
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _modelName.clear();
      _productDimension.clear();
      _ramSize.clear();
      _ramType.clear();
      _clockSpeed.clear();
      _voltage.clear();
      _fromFactor.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
    });
  }
String? selectedCategory;
String? selectedRam;
String? selectedModel;
String? selectedRamType;
String? selectedSpeed;
String? selectedRamSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ramdetails')
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
                  final ram = snapshot.data!.docs
                      .map((doc) => doc['name'] as String)
                      .toSet()
                      .toList();
                  final model = snapshot.data!.docs
                      .map((doc) => doc['model'] as String)
                      .toSet()
                      .toList();
                  final type = snapshot.data!.docs
                      .map((doc) => doc['ramtype'] as String)
                      .toSet()
                      .toList();
                  final speeds = snapshot.data!.docs
                      .map((doc) => doc['speed'] as String)
                      .toSet()
                      .toList();
                      final size = snapshot.data!.docs
                      .map((doc)=> doc['ramsize'] as String)
                      .toSet()
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text('Memory RAM', style: CustomText.title),
                        const SizedBox(height: 20),
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        const SizedBox(height: 20),
                        Form(
                            key: _formkey,
                            child: Column(children: [
                              AdminUi.admTextField(
                                  label:'Unique ID',
                                  textcontroller: idNum),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select RAM',
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
                                      selectedRam = value;
                                    });
                                  },
                                  dropdownMenuEntries: ram
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select RAM Type',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _ramType,
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
                                      selectedRamType = value;
                                    });
                                  },
                                  dropdownMenuEntries: type
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select RAM Size',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _ramSize,
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
                                      selectedRamSize = value;
                                    });
                                  },
                                  dropdownMenuEntries: size
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select RAM Speed',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _clockSpeed,
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
                              AdminUi.admTextField(
                                  label: 'Manufacturer',
                                  textcontroller: _manufacturer),
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
                                  label: 'Product Dimensions',
                                  textcontroller: _productDimension),
                              const SizedBox(height: 10),
                             
                              AdminUi.admTextField(
                                  label: 'Voltage', textcontroller: _voltage),
                              const SizedBox(height: 10),
                              
                              AdminUi.admTextField(
                                  label: 'Form Factor',
                                  textcontroller: _fromFactor),
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
                              const SizedBox(height: 30),
                            ])), // Textfromfield
                        AdminUiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.pop(context);
                            submitData();
                            AdminUiHelper.customSnackbar(
                                context, 'Item Added Successfully !');
                          }
                        }, text: 'Save'),
                        const SizedBox(height: 30)
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
