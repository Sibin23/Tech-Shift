import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateHeadset extends StatefulWidget {
  final String itemId;
  const UpdateHeadset({super.key, required this.itemId});

  @override
  State<UpdateHeadset> createState() => _UpdateHeadsetState();
}

class _UpdateHeadsetState extends State<UpdateHeadset> {
  final _formkey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final idNum = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _series = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final soundFeatures = TextEditingController();
  final _color = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _productDimension = TextEditingController();
  final _modelName = TextEditingController();
  final _connector = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  String? image;
  late String imageurl = '';
  String? selectedHeadset;
  String? selectedCategory;
  String? selectedSeries;
  String? selectedModel;
  String? selectedManufacturer;
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
        FirebaseStorage.instance.ref().child('Headsets/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('headsets')
        .doc(widget.itemId) // Use the itemId
        .update({
      'category': categoryName.text.trim().toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'soundfeatures': soundFeatures.text,
      'series': _series.text,
      'color': _color.text,
      'model': _modelName.text,
      'features': _specialFeatures.text,
      'productdimension': _productDimension.text,
      'connector': _connector.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    });
    setState(() {
      imageurl = '';
      categoryName.clear();
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      soundFeatures.clear();
      _newPrice.clear();
      _series.clear();
      _color.clear();
      _modelName.clear();
      _specialFeatures.clear();
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
        .collection('headsets')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        _productName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        idNum.text = data['idnum'];
        categoryName.text = data['category'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _manufacturer.text = data['manufacturer'];
        _series.text = data['series'];
        _color.text = data['color'];
        _modelName.text = data['model'];
        _specialFeatures.text = data['features'];
        _productDimension.text = data['productdimension'];
        _connector.text = data['connector'];
        _country.text = data['country'];
        soundFeatures.text = data['soundfeatures'];
        _itemWeight.text = data['itemweight'];
        _warranty.text = data['warranty'];
      }
    });
    super.initState();
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
            stream:
                FirebaseFirestore.instance.collection('headsets').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                const Center(
                    child: CircularProgressIndicator(
                        color: CustomColors.appTheme));
              }
              final headset = snapshot.data!.docs
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
              final series = snapshot.data!.docs
                  .map((doc) => doc['series'] as String)
                  .toSet()
                  .toList();
              final category = snapshot.data!.docs
                  .map((doc) => doc['category'] as String)
                  .toSet()
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Text('Gaming Headsets', style: CustomText.title),
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
                            controller: categoryName,
                            label: const Text(
                              'Select Category',
                              style: TextStyle(color: CustomColors.appTheme),
                            ),
                            menuStyle: const MenuStyle(
                                surfaceTintColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            hintText: 'Select Category',
                            width: MediaQuery.of(context).size.width * .93,
                            menuHeight: 300,
                            inputDecorationTheme: InputDecorationTheme(
                                hintStyle: const TextStyle(
                                    color: CustomColors.appTheme),
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
                        const SizedBox(height: 10),
                        DropdownMenu<String>(
                            controller: _productName,
                            menuStyle: const MenuStyle(
                                surfaceTintColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            label: const Text(
                              'Select Headset',
                              style: TextStyle(color: CustomColors.appTheme),
                            ),
                            width: MediaQuery.of(context).size.width * .93,
                            menuHeight: 300,
                            inputDecorationTheme: InputDecorationTheme(
                                hintStyle: const TextStyle(
                                    color: CustomColors.appTheme),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true),
                            onSelected: (value) {
                              setState(() {
                                selectedHeadset = value;
                              });
                            },
                            dropdownMenuEntries: headset
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList()),
                        const SizedBox(height: 10),
                        DropdownMenu<String>(
                            label: const Text(
                              'Select Manufacturer',
                              style: TextStyle(color: CustomColors.appTheme),
                            ),
                            controller: _manufacturer,
                            menuStyle: const MenuStyle(
                                surfaceTintColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            hintText: 'Select Manufacturer',
                            width: MediaQuery.of(context).size.width * .93,
                            menuHeight: 300,
                            inputDecorationTheme: InputDecorationTheme(
                                hintStyle: const TextStyle(
                                    color: CustomColors.appTheme),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true),
                            onSelected: (value) {
                              setState(() {
                                selectedManufacturer = value;
                              });
                            },
                            dropdownMenuEntries: manufacturer
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList()),
                        const SizedBox(height: 10),
                        DropdownMenu<String>(
                            controller: _series,
                            menuStyle: const MenuStyle(
                                surfaceTintColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            hintText: 'Select Series',
                            width: MediaQuery.of(context).size.width * .93,
                            menuHeight: 300,
                            inputDecorationTheme: InputDecorationTheme(
                                hintStyle: const TextStyle(
                                    color: CustomColors.appTheme),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true),
                            onSelected: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                            dropdownMenuEntries: series
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList()),
                        const SizedBox(height: 10),
                        DropdownMenu<String>(
                            controller: _modelName,
                            menuStyle: const MenuStyle(
                                surfaceTintColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            hintText: 'Select Model',
                            width: MediaQuery.of(context).size.width * .93,
                            menuHeight: 300,
                            inputDecorationTheme: InputDecorationTheme(
                                hintStyle: const TextStyle(
                                    color: CustomColors.appTheme),
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
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Old Price', textcontroller: _oldPrice),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'New Price', textcontroller: _newPrice),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Colour', textcontroller: _color),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Model Name', textcontroller: _modelName),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Sound Features',
                            textcontroller: soundFeatures),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Features',
                            textcontroller: _specialFeatures),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Product Dimensions',
                            textcontroller: _productDimension),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Connectivity', textcontroller: _connector),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Country', textcontroller: _country),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Item Weight', textcontroller: _itemWeight),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Warranty', textcontroller: _warranty),
                        const SizedBox(height: 30),
                      ])),
                  AdminUiHelper.customButton(context, () {
                    if (_formkey.currentState!.validate()) {
                      updateData();
                      AdminUiHelper.customSnackbar(
                          context, 'Item Added Successfully !');
                    }
                  }, text: 'Save'),
                  const SizedBox(height: 30)
                ]),
              );
            }),
      )),
    );
  }
}
