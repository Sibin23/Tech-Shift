import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddChairs extends StatefulWidget {
  const ScreenAddChairs({super.key});

  @override
  State<ScreenAddChairs> createState() => _ScreenAddChairsState();
}

class _ScreenAddChairsState extends State<ScreenAddChairs> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _color = TextEditingController();
  final _model = TextEditingController();
  final _modelName = TextEditingController();
  final _material = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _productDimension = TextEditingController();
  final _fillMaterial = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  static bool newArival = false;
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
        FirebaseStorage.instance.ref().child('Chairs/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'categoryid': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'manufacturer': _manufacturer.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'color': _color.text,
      'model': _model.text,
      'modelname': _modelName.text,
      'material': _material.text,
      'features': _specialFeatures.text,
      'productdimension': _productDimension.text,
      'fillmaterial': _fillMaterial.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'newarrival': newArival,
    };
    FirebaseFirestore.instance
        .collection('chairs')
        .doc(_productCategory.text.toLowerCase())
        .set(data);
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _color.clear();
      _model.clear();
      _modelName.clear();
      _material.clear();
      _specialFeatures.clear();
      _productDimension.clear();
      _fillMaterial.clear();
      _country.clear();
      _itemWeight.clear();
      newArival = false;
    });
    
  }
@override
  void dispose() {
    _productCategory;
    _productName;
    imageurl;
    _oldPrice;
    _newPrice;
    _color;
    _model;
    _modelName;
    _material;
    _specialFeatures;
    _productDimension;
    _fillMaterial;
    _country;
    _itemWeight;
    newArival;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            label: 'Category Name',
                            textcontroller: _productCategory),
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
                            label: 'Item Color', textcontroller: _color),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Item Model', textcontroller: _model),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Model Name', textcontroller: _modelName),
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
                            label: 'Item Weight', textcontroller: _itemWeight),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            value: newArival,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                newArival = value!;
                                              });
                                            }),
                                        Text('New Arrival',
                                            style: CustomText.title3)
                                      ])
                                ]))
                      ])),
                  AdminUiHelper.customButton(context, () {
                    if (_formkey.currentState!.validate()) {
                      submitData();
                      AdminUiHelper.customSnackbar(
                          context, 'Item Added Successfully !');
                    }
                  }, text: 'Save'),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
