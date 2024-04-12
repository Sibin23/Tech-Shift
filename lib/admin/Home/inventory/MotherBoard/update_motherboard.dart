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

class UpdateMotherboard extends StatefulWidget {
  final Map<String, dynamic> item;
  final String id;
  const UpdateMotherboard({super.key, required this.item, required this.id});

  @override
  State<UpdateMotherboard> createState() => _UpdateMotherboardState();
}

class _UpdateMotherboardState extends State<UpdateMotherboard> {
  final _formkey = GlobalKey<FormState>();
  String? image;
  late String imageurl = '';
  final _ramSlots = TextEditingController();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _modelName = TextEditingController();
  final _productDimension = TextEditingController();
  final _ssdslots = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _ramType = TextEditingController();
  final _ramMax = TextEditingController();
  final _processorSocket = TextEditingController();
  final _ssdType = TextEditingController();
  final _ports = TextEditingController();
  final _maxClock = TextEditingController();
  final _wattage = TextEditingController();
  final _formFactor = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  bool? isNew;
  bool? isPopular;
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
        FirebaseStorage.instance.ref().child('Motherboard/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  Future<void> updateData() async {
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: widget.id,
      category: motherboard,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(widget.id).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(widget.id).set(item);
    }
    if (isNew == false) {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection(newArival).doc(widget.id);
      await docRef.delete();
    }
    if (isPopular == false) {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection(popular).doc(widget.id);
      await docRef.delete();
    }
    FirebaseFirestore.instance.collection(motherboard).doc(widget.id).update({
      itemImage: imageurl.toString(),
      name: _productName.text,
      maxClock: _maxClock.text.trim(),
      model: _modelName.text,
      manufacturer: _manufacturer.text,
      cpuSocket: _processorSocket.text.trim(),
      ramType: _ramType.text.trim(),
      ramSize: _ramMax.text.trim(),
      ramSlots: _ramSlots.text.trim(),
      ssdType: _ssdType.text.trim(),
      ssdSlots: _ssdslots.text.trim(),
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      dimension: _productDimension.text,
      features: _specialFeatures.text,
      ports: _ports.text,
      wattage: _wattage.text,
      formFactor: _formFactor.text.trim(),
      country: _country.text,
      weight: _itemWeight.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular,
    });
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _productName.clear();
      _maxClock.clear();
      _modelName.clear();
      _manufacturer.clear();
      _processorSocket.clear();
      _ramType.clear();
      _ramMax.clear();
      _ramSlots.clear();
      _ssdType.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _productDimension.clear();
      _ssdslots.clear();
      _specialFeatures.clear();
      _ports.clear();
      _wattage.clear();
      _formFactor.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
      isNew = false;
      isPopular = false;
    });
  }

  @override
  void initState() {
    final data = widget.item;
    _productName.text = data[name];
    setState(() {
      image = imageurl;
    });
    imageurl = data[itemImage];
    _manufacturer.text = data[manufacturer];
    _oldPrice.text = data[oldPrice];
    _newPrice.text = data[newPrice];
    _modelName.text = data[model];
    _ramMax.text = data[ramSize];
    _productDimension.text = data[dimension];
    _ssdslots.text = data[ssdSlots];
    _ports.text = data[ports];
    _specialFeatures.text = data[features];
    _ramType.text = data[ramType];
    _ramSlots.text = data[ramSlots];
    _processorSocket.text = data[cpuSocket];
    _ssdType.text = data[ssdType];
    _maxClock.text = data[maxClock];
    _wattage.text = data[wattage];
    _formFactor.text = data[formFactor];
    _country.text = data[country];
    _itemWeight.text = data[weight];
    _warranty.text = data[warranty];
    isNew = data[newArival] == true ? isNew = true : isNew = false;
    isPopular = data[popular] == true ? isPopular = true : isPopular = false;
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
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('Update MotherBoard', style: CustomText.title),
              const SizedBox(height: 20),
              AdminUiHelper.customImageBox(() {
                pickImage();
              }, imageurl: imageurl),
              const SizedBox(height: 20),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      AdminUi.admTextField(
                          label: 'Product Name', textcontroller: _productName),
                      h10,
                      AdminUi.admTextField(
                          label: "Clock Speed", textcontroller: _maxClock),
                      h10,
                      AdminUi.admTextField(
                          label: 'Model Name', textcontroller: _modelName),
                      h10,
                      AdminUi.admTextField(
                          label: 'Manufacuturer',
                          textcontroller: _manufacturer),
                      h10,
                      AdminUi.admTextField(
                          label: "Socket Type",
                          textcontroller: _processorSocket),
                      h10,
                      AdminUi.admTextField(
                          label: 'Ram Type', textcontroller: _ramType),
                      h10,
                      AdminUi.admTextField(
                          label: 'Ram Slots', textcontroller: _ramSlots),
                      h10,
                      AdminUi.admTextField(
                          label: 'SSD Type', textcontroller: _ssdType),
                      h10,
                      AdminUi.admTextField(
                          label: 'SSD Slots', textcontroller: _ssdslots),
                      h10,
                      AdminUi.admTextField(
                          label: 'Old Price', textcontroller: _oldPrice),
                      h10,
                      AdminUi.admTextField(
                          label: 'New Price', textcontroller: _newPrice),
                      h10,
                      AdminUi.admTextField(
                          label: 'Product Dimensions',
                          textcontroller: _productDimension),
                      h10,
                      AdminUi.featuresTextfield(
                          label: 'Ports', textcontroller: _ports),
                      h10,
                      AdminUi.featuresTextfield(
                          label: 'Features', textcontroller: _specialFeatures),
                      h10,
                      AdminUi.admTextField(
                          label: 'Form Factor', textcontroller: _formFactor),
                      h10,
                      AdminUi.admTextField(
                          label: 'Power Consumption (W)',
                          textcontroller: _wattage),
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
                                  tristate: false,
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
                                  tristate: false,
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
                    ],
                  )),
              h30,
              AdminUiHelper.customButton(context, () {
                if (_formkey.currentState!.validate()) {
                  Navigator.pop(context);
                  updateData();
                  AdminUiHelper.customSnackbar(
                      context, 'Item Updated Successfully !');
                }
              }, text: 'Save'),
              h30
            ],
          ),
        )),
      ),
    );
  }
}
