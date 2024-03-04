import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddKeyboard extends StatefulWidget {
  const ScreenAddKeyboard({super.key});

  @override
  State<ScreenAddKeyboard> createState() => _ScreenAddKeyboardState();
}

class _ScreenAddKeyboardState extends State<ScreenAddKeyboard> {
  final _formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  final categoryName = TextEditingController();
  final productName = TextEditingController();
  final manufacturer = TextEditingController();
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
  String? sselectedKeyboard;
  String? selectedModel;
  String? selectedManufacturer;
  String? selectedCategory;

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
      'category': categoryName.text.toLowerCase(),
      'idnum': idNum.text,
      'image': imageurl.toString(),
      'name': productName.text,
      'manufacturer': manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'model': _modelName.text,
      'productdimension': _productDimension.text,
      'features': _specialFeatures.text,
      'connector': _connector.text,
      'material': _material.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text
    };
    FirebaseFirestore.instance
        .collection('keyboard')
        .doc(idNum.text.toLowerCase())
        .set(data);
    setState(() {
      categoryName.clear();
      imageurl = '';
      idNum.clear();
      productName.clear();
      manufacturer.clear();
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('keyboarddetails')
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
                    final keyboard = snapshot.data!.docs
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
                          Text('Gaming Keyboard', style: CustomText.title),
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
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: categoryName,
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
                                    label: const Text('Select Keyboard',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: productName,
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
                                        sselectedKeyboard = value;
                                      });
                                    },
                                    dropdownMenuEntries: keyboard
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
                                        selectedCategory = value;
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
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: manufacturer,
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
                                AdminUi.featuresTextfield(
                                    label: 'Features',
                                    textcontroller: _specialFeatures),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Connectivity',
                                    textcontroller: _connector),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Material',
                                    textcontroller: _material),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Country', textcontroller: _country),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Warranty',
                                    textcontroller: _warranty),
                              ])), // Text field
                          const SizedBox(height: 30),
                          AdminUiHelper.customButton(context, () {
                            if (_formkey.currentState!.validate()) {
                              submitData();
                              AdminUiHelper.customSnackbar(
                                  context, 'Item Added Successfully !');
                            }
                          }, text: 'Save'),
                        ]));
                  }))),
    );
  }
}
