import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ScreenAddPsu extends StatefulWidget {
  const ScreenAddPsu({super.key});

  @override
  State<ScreenAddPsu> createState() => _ScreenAddPsuState();
}

class _ScreenAddPsuState extends State<ScreenAddPsu> {
  final formkey = GlobalKey<FormState>();
  final productCategory = TextEditingController();
  final productName = TextEditingController();
  final manufacturer = TextEditingController();
  final oldPrice = TextEditingController();
  final newPrice = TextEditingController();
  final modelName = TextEditingController();
  final productDimension = TextEditingController();
  final specialFeatures = TextEditingController();
  final wattage = TextEditingController();
  final coolingMethod = TextEditingController();
  final fromFactor = TextEditingController();
  final country = TextEditingController();
  final itemWeight = TextEditingController();
  final warranty = TextEditingController();
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  late String imageurl = '';
  String? selectedCategory;
  String? selectedPsu;
  String? selectedModel;
  String? selectedWatt;
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
        FirebaseStorage.instance.ref().child('PSU/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  Future submitData() async {
    final data = {
      'category': productCategory.text.toLowerCase(),
      'idnum': idnum,
      'image': imageurl.toString(),
      'name': productName.text,
      'manufacturer': manufacturer.text,
      'oldprice': oldPrice.text,
      'newprice': newPrice.text,
      'model': modelName.text,
      'productdimension': productDimension.text,
      'features': specialFeatures.text,
      'coolingmethod': coolingMethod.text,
      'formfactor': fromFactor.text,
      'wattage': wattage.text,
      'country': country.text,
      'itemweight': itemWeight.text,
      'warranty': warranty.text,
    };
    FirebaseFirestore.instance.collection('psu').doc(idnum).set(data);
    setState(() {
      productCategory.clear();
      imageurl = '';
      productName.clear();
      manufacturer.clear();
      oldPrice.clear();
      newPrice.clear();
      modelName.clear();
      specialFeatures.clear();
      productDimension.clear();
      wattage.clear();
      coolingMethod.clear();
      fromFactor.clear();
      itemWeight.clear();
      warranty.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('psudetails')
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
                final psu = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final model = snapshot.data!.docs
                    .map((doc) => doc['model'] as String)
                    .toSet()
                    .toList();
                final watt = snapshot.data!.docs
                    .map((doc) => doc['wattage'] as String)
                    .toSet()
                    .toList();
                return SingleChildScrollView(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Text('PSU', style: CustomText.title),
                              const SizedBox(height: 20),
                              AdminUiHelper.customImageBox(() {
                                pickImage();
                              }, imageurl: imageurl),
                              const SizedBox(height: 20),
                              Form(
                                  key: formkey,
                                  child: Column(children: [
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Category',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: productCategory,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
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
                                        label: const Text(
                                          'Select PSU',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: productName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedPsu = value;
                                          });
                                        },
                                        dropdownMenuEntries: psu
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Model Name',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: modelName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
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
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Wattage',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: wattage,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedWatt = value;
                                          });
                                        },
                                        dropdownMenuEntries: watt
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Manufacturer',
                                        textcontroller: manufacturer),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Old Price',
                                        textcontroller: oldPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'New Price',
                                        textcontroller: newPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Product Dimensions',
                                        textcontroller: productDimension),
                                    space,
                                    AdminUi.featuresTextfield(
                                        label: 'Features',
                                        textcontroller: specialFeatures),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Cooling Method',
                                        textcontroller: coolingMethod),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Form Factor',
                                        textcontroller: fromFactor),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Country',
                                        textcontroller: country),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Item Weight',
                                        textcontroller: itemWeight),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Warranty',
                                        textcontroller: warranty),
                                    const SizedBox(height: 30),
                                  ])),
                              AdminUiHelper.customButton(context, () {
                                if (formkey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  submitData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Added Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30)
                            ]))));
              })),
    );
  }
}
