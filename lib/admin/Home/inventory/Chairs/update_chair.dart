import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateChair extends StatefulWidget {
  final String itemId;
  const UpdateChair({super.key, required this.itemId});

  @override
  State<UpdateChair> createState() => _UpdateChairState();
}

class _UpdateChairState extends State<UpdateChair> {
  final _formkey = GlobalKey<FormState>();
  final _idNum = TextEditingController();
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
      'idnum': _idNum.text,
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
      _idNum.clear();
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
        _idNum.text = data['idnum'];
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
    return Scaffold(
      appBar: AppBar(

        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chairs')
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
                              AdminUi.admTextField(
                                  label: 'Unique ID', textcontroller: _idNum),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Old Price',
                                  textcontroller: _oldPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'New Price',
                                  textcontroller: _newPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Color', textcontroller: _color),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Material', textcontroller: _material),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Special Features',
                                  textcontroller: _specialFeatures),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Product Dimension',
                                  textcontroller: _productDimension),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Fill Material',
                                  textcontroller: _fillMaterial),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _itemWeight),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: _warranty),
                            ])),
                        const SizedBox(height: 30),
                        AdminUiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
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
