import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final categoryName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final topCoolerMin = TextEditingController();
  final topCoolerMax = TextEditingController();
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
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  String? selectedCabinet;
  String? selectedCategory;
  String? selectedManufacturer;
  String? selectedModel;
  // add image
  late String imageurl = '';
  String? image;
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
      'image': imageurl.toString(),
      'name': _productName.text,
      'idnum': idnum,
      'category': categoryName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'topcoolermin': topCoolerMin.text.trim().toLowerCase(),
      'topcoolermax': topCoolerMax.text.trim().toLowerCase(),
      'model': _model.text,
      'productdimension': _productDimension.text,
      'material': _material.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'usb2': _usb2.text,
      'usb3': _usb3.text,
      'warranty': _warranty.text,
      'fansize': _fanSize.text,
      'fancount': _fancount.text,
    };
    FirebaseFirestore.instance.collection('cabinet').doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
      categoryName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      topCoolerMax.clear();
      topCoolerMin.clear();
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
                  .collection('cabinetdetails')
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
                final cabinet = snapshot.data!.docs
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
                            child: Column(children: [
                              Text('Cabinet', style: CustomText.title),
                              const SizedBox(height: 20),
                              AdminUiHelper.customImageBox(() {
                                pickImage();
                              }, imageurl: imageurl),
                              const SizedBox(height: 30),
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
                                        controller: _productName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Cabinet',
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
                                            selectedCabinet = value;
                                          });
                                        },
                                        dropdownMenuEntries: cabinet
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
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
                                    space,
                                    DropdownMenu<String>(
                                        controller: _model,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Model Name',
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
                                    AdminUi.admTextField(
                                        label: 'Number of ports USB 2.0',
                                        textcontroller: _usb2),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Number of Ports USB 3.0',
                                        textcontroller: _usb3),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Fan Size',
                                        textcontroller: _fanSize),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Fan Count',
                                        textcontroller: _fancount),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Old Price',
                                        textcontroller: _oldPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'New Price',
                                        textcontroller: _newPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label:
                                            'Top Cooler Minimum (in Millimeters)',
                                        textcontroller: topCoolerMin),
                                    space,
                                    AdminUi.admTextField(
                                        label:
                                            'Top Cooler Maximun (in Millimeters)',
                                        textcontroller: topCoolerMax),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Product Dimension',
                                        textcontroller: _productDimension),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Material',
                                        textcontroller: _material),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Country',
                                        textcontroller: _country),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Item Weight',
                                        textcontroller: _itemWeight),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Warranty',
                                        textcontroller: _warranty)
                                  ])),
                              const SizedBox(height: 30),
                              AdminUiHelper.customButton(context, () {
                                if (_formkey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  submitData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Added Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30),
                            ]))));
              })),
    );
  }
}
