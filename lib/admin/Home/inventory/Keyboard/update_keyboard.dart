import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class UpdateKeyboard extends StatefulWidget {
  final String itemId;
  const UpdateKeyboard({super.key, required this.itemId});

  @override
  State<UpdateKeyboard> createState() => _UpdateKeyboardState();
}

class _UpdateKeyboardState extends State<UpdateKeyboard> {
  final _formkey = GlobalKey<FormState>();
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
  String? image;
  late String imageurl = '';
  String? sselectedKeyboard;
  String? selectedModel;
  String? selectedManufacturer;
  String? selectedCategory;

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
        FirebaseStorage.instance.ref().child('Keyboard/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('keyboard')
        .doc(widget.itemId) // Use the itemId
        .update({
      'category': categoryName.text.toLowerCase(),
      'idnum': widget.itemId,
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
    });
    setState(() {
      categoryName.clear();
      imageurl = '';
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
  void initState() {
    FirebaseFirestore.instance
        .collection('keyboard')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        categoryName.text = data['category'];
        productName.text = data['name'];
        imageurl = data['image'];
        setState(() {
          image = imageurl;
        });
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _modelName.text = data['model'];
        manufacturer.text = data['manufacturer'];
        _productDimension.text = data['productdimension'];
        _specialFeatures.text = data['features'];
        _connector.text = data['connector'];
        _material.text = data['material'];
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
      appBar: AppBar(surfaceTintColor: Colors.white),
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('keyboard').snapshots(),
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
                        DropdownMenu<String>(
                            label: const Text('Select Category',
                                style: TextStyle(color: CustomColors.appTheme)),
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
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList()),
                        space,
                        DropdownMenu<String>(
                            label: const Text('Select Keyboard',
                                style: TextStyle(color: CustomColors.appTheme)),
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
                                sselectedKeyboard = value;
                              });
                            },
                            dropdownMenuEntries: keyboard
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList()),
                        space,
                        DropdownMenu<String>(
                            label: const Text('Select Model',
                                style: TextStyle(color: CustomColors.appTheme)),
                            controller: _modelName,
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
                            dropdownMenuEntries: model
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList()),
                        space,
                        DropdownMenu<String>(
                            label: const Text('Select Manufacturer',
                                style: TextStyle(color: CustomColors.appTheme)),
                            controller: manufacturer,
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
                                .map<DropdownMenuEntry<String>>((String value) {
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
                        AdminUi.featuresTextfield(
                            label: 'Features',
                            textcontroller: _specialFeatures),
                        space,
                        AdminUi.admTextField(
                            label: 'Connectivity', textcontroller: _connector),
                        space,
                        AdminUi.admTextField(
                            label: 'Material', textcontroller: _material),
                        space,
                        AdminUi.admTextField(
                            label: 'Country', textcontroller: _country),
                        space,
                        AdminUi.admTextField(
                            label: 'Item Weight', textcontroller: _itemWeight),
                        space,
                        AdminUi.admTextField(
                            label: 'Warranty', textcontroller: _warranty),
                      ])), // Text field
                  const SizedBox(height: 30),
                  AdminUiHelper.customButton(context, () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.pop(context);
                      updateData();
                      AdminUiHelper.customSnackbar(
                          context, 'Item Updated Successfully !');
                    }
                  }, text: 'Save'),
                ]),
              );
            }),
      )),
    );
  }
}
