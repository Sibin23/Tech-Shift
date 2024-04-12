import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

import '../../../utils/utils_text_style.dart';

class ScreenAddCoolers extends StatefulWidget {
  const ScreenAddCoolers({super.key});

  @override
  State<ScreenAddCoolers> createState() => _ScreenAddCoolersState();
}

class _ScreenAddCoolersState extends State<ScreenAddCoolers> {
  final _formkey = GlobalKey<FormState>();
  final _features = TextEditingController();
  final size = TextEditingController();
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
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  late String imageurl = '';
  String? selectedCategory;
  String? selectedCooler;
  String? selectedFans;
  String? selectedManufacturer;
  String? selectedMethod;
  String? selectedSpeed;
  bool isNew = false;
  bool isPopular = false;
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

// submit
  Future submitData() async {
    final data = {
      itemImage: imageurl.toString(),
      category: cooler,
      uniqueId: idnum,
      name: _productName.text,
      manufacturer: _manufacturer.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      connectivity: _connector.text,
      voltage: _voltage.text,
      wattage: _wattage.text,
      cooling: _coolingMethod.text,
      fansize: size.text,
      noise: _noiseLevel.text,
      fancount: _fans.text,
      dimension: _productDimension.text,
      features: _features.text,
      material: _material.text,
      speed: _speed.text,
      country: _country.text,
      weight: _itemWeight.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular,
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: cooler,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(cooler).doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _features.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _connector.clear();
      _voltage.clear();
      _wattage.clear();
      _fans.clear();
      _coolingMethod.clear();
      _noiseLevel.clear();
      size.clear();
      _productDimension.clear();
      _material.clear();
      _speed.clear();
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
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text('Add Coolers', style: CustomText.title),
                        h30,
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        h30,
                        Form(
                            key: _formkey,
                            child: Column(children: [
                              AdminUi.admTextField(
                                  label: "Product Name",
                                  textcontroller: _productName),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Manufacuturer',
                                  textcontroller: _manufacturer),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Cooling Method',
                                  textcontroller: _coolingMethod),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Speed', textcontroller: _speed),
                              h10,
                              AdminUi.admTextField(
                                  label: 'No. of Fans', textcontroller: _fans),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Old Price',
                                  textcontroller: _oldPrice),
                              h10,
                              AdminUi.admTextField(
                                  label: 'New Price',
                                  textcontroller: _newPrice),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Size', textcontroller: size),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Connector Type',
                                  textcontroller: _connector),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Voltage', textcontroller: _voltage),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Wattage', textcontroller: _wattage),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Noise Level',
                                  textcontroller: _noiseLevel),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Product Dimensions',
                                  textcontroller: _productDimension),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Features', textcontroller: _features),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Material', textcontroller: _material),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _itemWeight),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: _warranty),
                              h10,
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(children: [
                                      Checkbox(
                                          tristate: false,
                                          activeColor: CustomColors.appTheme,
                                          value: isNew,
                                          onChanged: (newValue) {
                                            setState(() {
                                              isNew = newValue!;
                                            });
                                          }),
                                      Text('New Arrival',
                                          style: CustomText.categoryTitleText)
                                    ]),
                                    Row(children: [
                                      Checkbox(
                                          tristate: false,
                                          activeColor: CustomColors.appTheme,
                                          value: isPopular,
                                          onChanged: (newValue) {
                                            setState(() {
                                              isPopular = newValue!;
                                            });
                                          }),
                                      Text('Popular Item',
                                          style: CustomText.categoryTitleText)
                                    ])
                                  ])
                            ])),
                        h30,
                        AdminUiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.pop(context);
                            submitData();
                            AdminUiHelper.customSnackbar(
                                context, 'Item Added Successfully !');
                          }
                        }, text: 'Save'),
                        h30
                      ]))))),
    );
  }
}
