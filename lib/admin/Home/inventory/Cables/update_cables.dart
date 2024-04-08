import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class UpdateCable extends StatefulWidget {
  final String itemId;
  const UpdateCable({super.key, required this.itemId});

  @override
  State<UpdateCable> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateCable> {
  final _formkey = GlobalKey<FormState>();
  final _speed = TextEditingController();
  final categoryName = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _color = TextEditingController();
  final _pinNumbers = TextEditingController();
  final _itemWeight = TextEditingController();
  final _modelName = TextEditingController();
  final _wattage = TextEditingController();
  final _voltage = TextEditingController();
  final _productDimension = TextEditingController();
  final _country = TextEditingController();
  final _warranty = TextEditingController();
  late String imageurl = '';
  String? selectedCategory;
  String? image;
  String? selectedCable;
  String? selectedModel;
  String? selectedManufacturer;
  String? selectedSpeed;
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
        FirebaseStorage.instance.ref().child('Cables/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance.collection('cables').doc(widget.itemId).update({
      'image': imageurl.toString(),
      'name': _productName.text,
      'idnum': widget.itemId,
      'category': categoryName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'color': _color.text,
      'pins': _pinNumbers.text,
      'model': _modelName.text,
      'wattage': _wattage.text,
      'voltage': _voltage.text,
      'speed': _speed.text,
      'productdimension': _productDimension.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'Warranty': _warranty.text,
    });
    setState(() {
      imageurl = '';
      categoryName.clear();
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _color.clear();
      _speed.clear();
      _pinNumbers.clear();
      _modelName.clear();
      _wattage.clear();
      _voltage.clear();
      _productDimension.clear();
      _itemWeight.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('cables')
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
        categoryName.text = data['category'];
        _manufacturer.text = data['manufacturer'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _color.text = data['color'];
        _pinNumbers.text = data['pins'];
        _modelName.text = data['modelname'];
        _wattage.text = data['wattage'];
        _speed.text = data['speed'];
        _voltage.text = data['voltage'];
        _productDimension.text = data['productdimension'];
        _country.text = data['country'];
        _itemWeight.text = data['itemweight'];
        _warranty.text = data['Warranty'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cabledetails')
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
                final cable = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final manufacturer = snapshot.data!.docs
                    .map((doc) => doc['manufacturer'] as String)
                    .toSet()
                    .toList();
                final speed = snapshot.data!.docs
                    .map((doc) => doc['speed'] as String)
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
                              Text('Cables', style: CustomText.title),
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
                                        hintText: 'Select Cable',
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
                                            selectedCable = value;
                                          });
                                        },
                                        dropdownMenuEntries: cable
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
                                        controller: _speed,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Transfer Rate',
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
                                            selectedSpeed = value;
                                          });
                                        },
                                        dropdownMenuEntries: speed
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        controller: _modelName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        hintText: 'Select Model name',
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
                                        label: 'Old Price',
                                        textcontroller: _oldPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'New Price',
                                        textcontroller: _newPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Item Colour',
                                        textcontroller: _color),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Number of Pins',
                                        textcontroller: _pinNumbers),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Wattage',
                                        textcontroller: _wattage),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Voltage',
                                        textcontroller: _voltage),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Product Dimenstions',
                                        textcontroller: _productDimension),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Item Weight',
                                        textcontroller: _itemWeight),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Country',
                                        textcontroller: _country),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Warranty',
                                        textcontroller: _warranty),
                                  ])),
                              const SizedBox(height: 30),
                              AdminUiHelper.customButton(context, () {
                                if (_formkey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  updateData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Updated Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30),
                            ]))));
              })),
    );
  }
}
