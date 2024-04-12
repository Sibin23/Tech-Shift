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

class ScreenAddCabinet extends StatefulWidget {
  const ScreenAddCabinet({super.key});

  @override
  State<ScreenAddCabinet> createState() => _ScreenAddCabinetState();
}

class _ScreenAddCabinetState extends State<ScreenAddCabinet> {
  final _formkey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _topCoolerMin = TextEditingController();
  final _topCoolerMax = TextEditingController();
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
  final idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
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

  // add to firefase
  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Cabinet/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      itemImage: imageurl.toString(),
      name: _productName.text,
      uniqueId: idnum,
      category: cabinet,
      manufacturer: _manufacturer.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      topCoolerMin: _topCoolerMin.text.trim().toLowerCase(),
      topCoolerMax: _topCoolerMax.text.trim().toLowerCase(),
      model: _model.text,
      dimension: _productDimension.text,
      material: _material.text,
      country: _country.text,
      weight: _itemWeight.text,
      usb2: _usb2.text,
      usb3: _usb3.text,
      warranty: _warranty.text,
      fansize: _fanSize.text,
      fancount: _fancount.text,
      newArival: isNew,
      popular: isPopular,
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: cabinet,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(cabinet).doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _topCoolerMax.clear();
      _topCoolerMin.clear();
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
                        Text('Cabinet', style: CustomText.title),
                        h30,
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        h30,
                        Form(
                            key: _formkey,
                            child: Column(children: [
                              AdminUi.admTextField(
                                  label: 'Product Name',
                                  textcontroller: _productName),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Manufacturer',
                                  textcontroller: _manufacturer),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Model Name', textcontroller: _model),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Number of ports USB 2.0',
                                  textcontroller: _usb2),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Number of Ports USB 3.0',
                                  textcontroller: _usb3),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Fan Size', textcontroller: _fanSize),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Fan Count',
                                  textcontroller: _fancount),
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
                                  label: 'Top Cooler Minimum (in Millimeters)',
                                  textcontroller: _topCoolerMin),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Top Cooler Maximun (in Millimeters)',
                                  textcontroller: _topCoolerMax),
                              h10,
                              AdminUi.admTextField(
                                  label: 'Product Dimension',
                                  textcontroller: _productDimension),
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
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(children: [
                                      Checkbox(
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
                        h30,
                      ]))))),
    );
  }
}
