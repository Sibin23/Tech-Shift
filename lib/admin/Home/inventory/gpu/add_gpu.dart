import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ScreenAddGpu extends StatefulWidget {
  const ScreenAddGpu({super.key});

  @override
  State<ScreenAddGpu> createState() => _ScreenAddGpuState();
}

class _ScreenAddGpuState extends State<ScreenAddGpu> {
  final formkey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _modelName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _support = TextEditingController();
  final _clockSpeed = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _color = TextEditingController();
  final _features = TextEditingController();
  final _maxResolution = TextEditingController();
  final _dimension = TextEditingController();
  final _ramType = TextEditingController();
  final _ramSize = TextEditingController();
  final _recPsu = TextEditingController();
  final _wattage = TextEditingController();
  final _country = TextEditingController();
  final _weight = TextEditingController();
  final _warranty = TextEditingController();
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  late String imageurl = '';
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
        FirebaseStorage.instance.ref().child('Graphics Card/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  Future submitData() async {
    final data = {
      itemImage: imageurl.toString(),
      category: gpu,
      uniqueId: idnum,
      name: _productName.text,
      model: _modelName.text,
      manufacturer: _manufacturer.text,
      support: _support.text,
      speed: _clockSpeed.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      color: _color.text,
      features: _features.text,
      maxResolution: _maxResolution.text,
      dimension: _dimension.text,
      ramType: _ramType.text,
      ramSize: _ramSize.text,
      recPsu: _recPsu.text,
      wattage: _wattage.text,
      country: _country.text,
      weight: _weight.text,
      warranty: _warranty.text.trim(),
      newArival: isNew,
      popular: isPopular
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: gpu,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(gpu).doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
      _modelName.clear();
      _manufacturer.clear();
      _support.clear();
      _clockSpeed.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _color.clear();
      _features.clear();
      _maxResolution.clear();
      _dimension.clear();
      _ramType.clear();
      _ramSize.clear();
      _recPsu.clear();
      _wattage.clear();
      _country.clear();
      _weight.clear();
      _warranty.clear();
      isNew = false;
      isPopular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white),
      body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text('Add GPU', style: CustomText.title),
                        h30,
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        h30,
                        Form(
                            key: formkey,
                            child: Column(children: [
                              AdminUi.admTextField(
                                  label: "Product Name",
                                  textcontroller: _productName),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Model', textcontroller: _modelName),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Manufacuterer',
                                  textcontroller: _manufacturer),
                              h10,
                              AdminUi.admTextField(
                                  label: "Feature Support",
                                  textcontroller: _support),
                              h10,
                              AdminUi.admTextField(
                                  label: 'GPU Clock Speed',
                                  textcontroller: _clockSpeed),
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
                                  label: 'Colour', textcontroller: _color),
                              h10,
                              AdminUi.featuresTextfield(
                                  label: 'Features', textcontroller: _features),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Max Resolution',
                                  textcontroller: _maxResolution),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Product Dimensions',
                                  textcontroller: _dimension),
                              h10,
                              AdminUi.admTextField(
                                  label: 'RAM Type', textcontroller: _ramType),
                              h10,
                              AdminUi.admTextField(
                                  label: 'RAM Size', textcontroller: _ramSize),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Recomended PSU',
                                  textcontroller: _recPsu),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Wattage', textcontroller: _wattage),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _weight),
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
                          if (formkey.currentState!.validate()) {
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
