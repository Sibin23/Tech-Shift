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

class ScreenAddChairs extends StatefulWidget {
  const ScreenAddChairs({super.key});

  @override
  State<ScreenAddChairs> createState() => _ScreenAddChairsState();
}

class _ScreenAddChairsState extends State<ScreenAddChairs> {
  final _formkey = GlobalKey<FormState>();
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
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  String? selectedCategory;
  String? selectedChair;
  String? selectedManufacturer;
  String? selectedModel;
  late String imageurl = '';
  bool isNew = false;
  bool isPopular = false;
  Future<void> pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
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

  // submit
  Future submitData() async {
    final data = {
      itemImage: imageurl.toString(),
      uniqueId: idnum,
      category: chair,
      name: _productName.text,
      manufacturer: _manufacturer.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      color: _color.text,
      model: _model.text,
      material: _material.text,
      features: _specialFeatures.text,
      dimension: _productDimension.text,
      fillMaterial: _fillMaterial.text,
      country: _country.text,
      weight: _itemWeight.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular,
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: chair,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(chair).doc(idnum).set(data);
    setState(() {
      imageurl = '';
      _productName.clear();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('Chairs', style: CustomText.title),
                h30,
                AdminUiHelper.customImageBox(() {
                  pickImage();
                }, imageurl: imageurl),
                h30,
                Form(
                    key: _formkey,
                    child: Column(children: [
                      AdminUi.admTextField(
                          label: 'Product Name', textcontroller: _productName),
                      h10,
                      AdminUi.admTextField(
                          label: 'Manufacturer', textcontroller: _manufacturer),
                      h10,
                      AdminUi.admTextField(
                          label: "Model", textcontroller: _model),
                      h10,
                      AdminUi.admTextField(
                          label: 'Old Price', textcontroller: _oldPrice),
                      h10,
                      AdminUi.admTextField(
                          label: 'New Price', textcontroller: _newPrice),
                      h10,
                      AdminUi.admTextField(
                          label: 'Item Color', textcontroller: _color),
                      h10,
                      AdminUi.admTextField(
                          label: 'Material', textcontroller: _material),
                      h10,
                      AdminUi.admTextField(
                          label: 'Special Features',
                          textcontroller: _specialFeatures),
                      h10,
                      AdminUi.admTextField(
                          label: 'Product Dimension',
                          textcontroller: _productDimension),
                      h10,
                      AdminUi.admTextField(
                          label: 'Fill Material',
                          textcontroller: _fillMaterial),
                      h10,
                      AdminUi.admTextField(
                          label: 'Country', textcontroller: _country),
                      h10,
                      AdminUi.admTextField(
                          label: 'Item Weight', textcontroller: _itemWeight),
                      h10,
                      AdminUi.admTextField(
                          label: 'Warranty', textcontroller: _warranty),
                      h10,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],
            ),
          ),
        ),
      )),
    );
  }
}
