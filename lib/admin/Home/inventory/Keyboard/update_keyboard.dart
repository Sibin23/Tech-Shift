import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateKeyboard extends StatefulWidget {
  final String itemId;
  const UpdateKeyboard({super.key, required this.itemId});

  @override
  State<UpdateKeyboard> createState() => _UpdateKeyboardState();
}

class _UpdateKeyboardState extends State<UpdateKeyboard> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _productDimension = TextEditingController();
  final _modelName = TextEditingController();
  final _connector = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _material = TextEditingController();
  final _warranty = TextEditingController();
  String? image;
  late String imageurl = '';

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
        FirebaseStorage.instance.ref().child('Keyboard/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('keyboard')
        .doc(widget.itemId) // Use the itemId
        .update({
      'categoryid': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'modelname': _modelName.text,
      'productdimension': _productDimension.text,
      'features': _specialFeatures.text,
      'connector': _connector.text,
      'material': _material.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    });
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _modelName.clear();
      _specialFeatures.clear();
      _material.clear();
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
        .collection('keyboard')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        _productCategory.text = data['categoryid'];
        _productName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _modelName.text = data['model'];
        _manufacturer.text = data['manufacturer'];
        _productDimension.text = data['productdimension'];
        _specialFeatures.text = data['features'];
        _connector.text = data['connector'];
        _material.text = data['material'];
        _country.text = data['country'];
        _itemWeight.text = data['country'];
        _warranty.text = data['warranty'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Text('Gaming Keyboard', style: CustomText.title),
            const SizedBox(height: 20),
            AdminUiHelper.customImageBox(() {
              pickImage();
            }, imageurl: imageurl),
            const SizedBox(height: 20),
            Form(
                key: _formkey,
                child: Column(children: [
                  AdminUi.admTextField(
                      label: 'Category Name', textcontroller: _productCategory),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Product Name', textcontroller: _productName),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Manufacturer', textcontroller: _manufacturer),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Old Price', textcontroller: _oldPrice),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'New Price', textcontroller: _newPrice),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Model Name', textcontroller: _modelName),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Product Dimensions',
                      textcontroller: _productDimension),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Features', textcontroller: _specialFeatures),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Connectivity', textcontroller: _connector),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Material', textcontroller: _material),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(label: 'Country', textcontroller: _country),
                  const SizedBox(height: 10),
                  AdminUi.admTextField(
                      label: 'Warranty', textcontroller: _warranty),
                ])), // Text field
            const SizedBox(height: 30),
            AdminUiHelper.customButton(context, () {
              if (_formkey.currentState!.validate()) {
                updateData();
                AdminUiHelper.customSnackbar(context, 'Item Added Successfully !');
              }
            }, text: 'Save'),
          ]),
        ),
      )),
    );
  }
}