import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class UpdateMouse extends StatefulWidget {
  final String itemId;
  const UpdateMouse({super.key, required this.itemId});

  @override
  State<UpdateMouse> createState() => _UpdateMouseState();
}

class _UpdateMouseState extends State<UpdateMouse> {
  final _formkey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final productName = TextEditingController();
  final manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final modelName = TextEditingController();
  final _productDimension = TextEditingController();
  final _series = TextEditingController();
  final _color = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _dpi = TextEditingController();
  final _buttons = TextEditingController();
  final _connector = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  String? image;
  late String imageurl = '';
  String? selectedCategory;
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedMouse;
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
        FirebaseStorage.instance.ref().child('Mouse/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('mouse')
        .doc(widget.itemId) 
        .update({
      'category': categoryName.text,
      'idnum': widget.itemId,
      'image': imageurl,
      'name': productName.text,
      'manufacturer': manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'model': modelName.text,
      'productdimension': _productDimension.text,
      'series': _series.text,
      'color': _color.text,
      'features': _specialFeatures.text,
      'dpi': _dpi.text,
      'buttons': _buttons.text,
      'connectivity': _connector.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    });
    setState(() {
      categoryName.clear();
      imageurl = '';
      productName.clear();
      manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      modelName.clear();
      _productDimension.clear();
      _series.clear();
      _color.clear();
      _specialFeatures.clear();
      _dpi.clear();
      _buttons.clear();
      _connector.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('mouse')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        productName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        categoryName.text = data['category'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        modelName.text = data['model'];
        manufacturer.text = data['manufacturer'];
        _productDimension.text = data['productdimension'];
        _series.text = data['series'];
        _color.text = data['color'];
        _specialFeatures.text = data['features'];
        _dpi.text = data['dpi'];
        _buttons.text = data['buttons'];
        _connector.text = data['connectivity'];
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
      appBar: AppBar(surfaceTintColor: Colors.white,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('mouse').snapshots(),
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
                final mouse = snapshot.data!.docs
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
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text('Gaming Mouse', style: CustomText.title),
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
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: categoryName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
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
                                    label: const Text('Select Mouse',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: productName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedMouse = value;
                                      });
                                    },
                                    dropdownMenuEntries: mouse
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                              space,
                                DropdownMenu<String>(
                                    label: const Text('Select Model',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: modelName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
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
                                    label: const Text('Select Manufacturer',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: manufacturer,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
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
                                    dropdownMenuEntries: manufactured
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                              space,
                                AdminUi.admTextField(
                                    label: 'Series', textcontroller: _series),
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
                                    label: 'Product Dimensions',
                                    textcontroller: _productDimension),
                              space,
                                AdminUi.admTextField(
                                    label: 'Colour', textcontroller: _color),
                              space,
                                AdminUi.featuresTextfield(
                                    label: 'Features',
                                    textcontroller: _specialFeatures),
                              space,
                                AdminUi.admTextField(
                                    label: 'DPI', textcontroller: _dpi),
                              space,
                                AdminUi.admTextField(
                                    label: 'Buttons', textcontroller: _buttons),
                              space,
                                AdminUi.admTextField(
                                    label: 'Connectivity',
                                    textcontroller: _connector),
                              space,
                                AdminUi.admTextField(
                                    label: 'Country', textcontroller: _country),
                              space,
                                AdminUi.admTextField(
                                    label: 'Item Weight',
                                    textcontroller: _itemWeight),
                              space,
                                AdminUi.admTextField(
                                    label: 'Warranty',
                                    textcontroller: _warranty),
                              space,
                              ])), // TextFormField
                          AdminUiHelper.customButton(context, () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.pop(context);
                              updateData();
                              AdminUiHelper.customSnackbar(
                                  context, 'Item Updated Successfully !');
                            }
                          }, text: 'Save'),
                          const SizedBox(height: 30)
                        ])));
              }),
        ),
      ),
    );
  }
}
