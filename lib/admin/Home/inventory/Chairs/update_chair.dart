import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class UpdateChair extends StatefulWidget {
  final String itemId;
  const UpdateChair({super.key, required this.itemId});

  @override
  State<UpdateChair> createState() => _UpdateChairState();
}

class _UpdateChairState extends State<UpdateChair> {
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
  String? selectedCategory;
  String? selectedChair;
  String? selectedManufacturer;
  String? selectedModel;
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

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Chairs/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('chairs')
        .doc(widget.itemId) // Use the itemId
        .update({
      'image': imageurl.toString(),
      'idnum': widget.itemId,
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
    });
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
  void initState() {
    FirebaseFirestore.instance
        .collection('chairs')
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
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _manufacturer.text = data['manufacturer'];
        _color.text = data['color'];
        _model.text = data['model'];
        _material.text = data['material'];
        _specialFeatures.text = data['features'];
        _productDimension.text = data['productdimension'];
        _warranty.text = data['warranty'];
        _fillMaterial.text = data['fillmaterial'];
        _itemWeight.text = data['itemweight'];
        _country.text = data['country'];
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
            stream: FirebaseFirestore.instance.collection('chairs').snapshots(),
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
                              space,
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
                              space,
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
                              space,
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
                              space,
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
                                  label: 'Item Color', textcontroller: _color),
                              space,
                              AdminUi.admTextField(
                                  label: 'Material', textcontroller: _material),
                              space,
                              AdminUi.admTextField(
                                  label: 'Special Features',
                                  textcontroller: _specialFeatures),
                              space,
                              AdminUi.admTextField(
                                  label: 'Product Dimension',
                                  textcontroller: _productDimension),
                              space,
                              AdminUi.admTextField(
                                  label: 'Fill Material',
                                  textcontroller: _fillMaterial),
                              space,
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                              space,
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _itemWeight),
                              space,
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: _warranty),
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
