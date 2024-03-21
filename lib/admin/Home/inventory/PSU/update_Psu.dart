import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdatePsu extends StatefulWidget {
  final String itemId;
  const UpdatePsu({super.key, required this.itemId});

  @override
  State<UpdatePsu> createState() => _UpdatePsuState();
}

class _UpdatePsuState extends State<UpdatePsu> {
  final formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
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
  late String imageurl = '';
  String? selectedCategory;
  String? selectedPsu;
  String? selectedModel;
  String? selectedWatt;
  String? image;
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
updateData() {
    FirebaseFirestore.instance
        .collection('psu')
        .doc(widget.itemId) // Use the itemId
        .update({
       'category': productCategory.text.toLowerCase(),
      'idnum': idNum.text.trim().toString(),
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
    });
    setState(() {
      imageurl = '';
      idNum.clear();
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
  void initState() {
    FirebaseFirestore.instance
        .collection('psu')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        productCategory.text = data['category'];
        idNum.text = data['idnum'];
        productName.text = data['name'];
        imageurl = data['image'];
        setState(() {
          image = imageurl;
        });
        oldPrice.text = data['oldprice'];
        newPrice.text = data['newprice'];
        modelName.text = data['model'];
        manufacturer.text = data['manufacturer'];
        newPrice.text = data['newprice'];
        oldPrice.text = data['oldprice'];
        productDimension.text = data['productdimension'];
        specialFeatures.text = data['features'];
        coolingMethod.text = data['coolingmethod'];
        fromFactor.text = data['formfactor'];
        wattage.text = data['wattage'];
        country.text = data['country'];
        itemWeight.text = data['itemweight'];
        warranty.text = data['warranty'];
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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('psu').snapshots(),
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
                                    AdminUi.admTextField(
                                        label: 'Unique Id',
                                        textcontroller: idNum),
                                    space,
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
                                        width: MediaQuery.of(context).size.width *
                                            .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
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
                                        label: const Text(
                                          'Select PSU',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: productCategory,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width: MediaQuery.of(context).size.width *
                                            .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
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
                                        controller: productCategory,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width: MediaQuery.of(context).size.width *
                                            .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
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
                                        label: const Text(
                                          'Select Wattage',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: productCategory,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width: MediaQuery.of(context).size.width *
                                            .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
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
                                    AdminUi.admTextField(
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
                                  updateData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Updated Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30)
                            ]))));
              })),
    );
  }
}
