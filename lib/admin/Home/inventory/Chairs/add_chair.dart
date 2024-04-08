import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ScreenAddChairs extends StatefulWidget {
  const ScreenAddChairs({super.key});

  @override
  State<ScreenAddChairs> createState() => _ScreenAddChairsState();
}

class _ScreenAddChairsState extends State<ScreenAddChairs> {
  final _formkey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _color = TextEditingController();
  final _model = TextEditingController();
  final _material = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _productDimension = TextEditingController();
  final _fillMaterial = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  String? selectedCategory;
  String? selectedChair;
  String? selectedManufacturer;
  String? selectedModel;
  late String imageurl = '';
  Future<void> pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {});
    }
  }

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Chairs/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'image': imageurl.toString(),
      'idnum': idnum,
      'category': categoryName.text,
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'color': _color.text,
      'model': _model.text,
      'material': _material.text,
      'features': _specialFeatures.text,
      'productdimension': _productDimension.text,
      'fillmaterial': _fillMaterial.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    };
    FirebaseFirestore.instance.collection('chairs').doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
      categoryName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _color.clear();
      _model.clear();
      _material.clear();
      _specialFeatures.clear();
      _productDimension.clear();
      _fillMaterial.clear();
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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chairdetails')
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
              final chair = snapshot.data!.docs
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
                    child: Column(
                      children: [
                        Text('Chairs', style: CustomText.title),
                        const SizedBox(height: 20),
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        const SizedBox(height: 20),
                        Form(
                            key: _formkey,
                            child: Column(children: [
                              DropdownMenu<String>(
                                  controller: categoryName,
                                  menuStyle: const MenuStyle(
                                      surfaceTintColor:
                                          MaterialStatePropertyAll(
                                              Colors.white)),
                                  hintText: 'Select Category',
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  menuHeight: 300,
                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(
                                          color: CustomColors.appTheme),
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
                              AdminUi.space,
                              DropdownMenu<String>(
                                  controller: _productName,
                                  menuStyle: const MenuStyle(
                                      surfaceTintColor:
                                          MaterialStatePropertyAll(
                                              Colors.white)),
                                  hintText: 'Select Chair',
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  menuHeight: 300,
                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(
                                          color: CustomColors.appTheme),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      fillColor: Colors.white,
                                      filled: true),
                                  onSelected: (value) {
                                    setState(() {
                                      selectedChair = value;
                                    });
                                  },
                                  dropdownMenuEntries: chair
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              AdminUi.space,
                              DropdownMenu<String>(
                                  controller: _manufacturer,
                                  menuStyle: const MenuStyle(
                                      surfaceTintColor:
                                          MaterialStatePropertyAll(
                                              Colors.white)),
                                  hintText: 'Select Manufacturer',
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  menuHeight: 300,
                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(
                                          color: CustomColors.appTheme),
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
                                  dropdownMenuEntries: manufacturer
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              AdminUi.space,
                              DropdownMenu<String>(
                                  controller: _model,
                                  menuStyle: const MenuStyle(
                                      surfaceTintColor:
                                          MaterialStatePropertyAll(
                                              Colors.white)),
                                  hintText: 'Select Model',
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  menuHeight: 300,
                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(
                                          color: CustomColors.appTheme),
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
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Old Price',
                                  textcontroller: _oldPrice),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'New Price',
                                  textcontroller: _newPrice),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Item Color', textcontroller: _color),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Material', textcontroller: _material),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Special Features',
                                  textcontroller: _specialFeatures),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Product Dimension',
                                  textcontroller: _productDimension),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Fill Material',
                                  textcontroller: _fillMaterial),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _itemWeight),
                              AdminUi.space,
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: _warranty),
                            ])),
                        const SizedBox(height: 30),
                        AdminUiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            submitData();
                            AdminUiHelper.customSnackbar(
                                context, 'Item Added Successfully !');
                          }
                        }, text: 'Save'),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
