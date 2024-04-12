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

class UpdatePsu extends StatefulWidget {
  final String id;
  final Map<String, dynamic> item;
  const UpdatePsu({super.key, required this.id, required this.item});

  @override
  State<UpdatePsu> createState() => _UpdatePsuState();
}

class _UpdatePsuState extends State<UpdatePsu> {
  final formkey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _modelName = TextEditingController();
  final _productDimension = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _wattage = TextEditingController();
  final _coolingMethod = TextEditingController();
  final _fromFactor = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  late String imageurl = '';
  bool? isNew;
  bool? isPopular;
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
        FirebaseStorage.instance.ref().child('PSU/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

 Future<void> updateData() async{
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: widget.id,
      category: psu,
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
    FirebaseFirestore.instance.collection(psu).doc(widget.id).update({
      itemImage: imageurl.toString(),
      name: _productName.text,
      manufacturer: _manufacturer.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      model: _modelName.text,
      dimension: _productDimension.text,
      features: _specialFeatures.text,
      coolingMethod: _coolingMethod.text,
      formFactor: _fromFactor.text,
      wattage: _wattage.text.trim(),
      country: _country.text,
      weight: _itemWeight.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular
    });
    setState(() {
      imageurl = '';
      _productName.clear();
      _manufacturer.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _modelName.clear();
      _specialFeatures.clear();
      _productDimension.clear();
      _wattage.clear();
      _coolingMethod.clear();
      _fromFactor.clear();
      _itemWeight.clear();
      _warranty.clear();
      isNew = false;
      isPopular = false;
    });
  }

  @override
  void initState() {
    final data = widget.item;
    imageurl = data[itemImage];
    setState(() {
      image = imageurl;
    });
    _productName.text = data[name];
    _oldPrice.text = data[oldPrice];
    _newPrice.text = data[newPrice];
    _modelName.text = data[model];
    _manufacturer.text = data[manufacturer];
    _newPrice.text = data[newPrice];
    _oldPrice.text = data[oldPrice];
    _productDimension.text = data[dimension];
    _specialFeatures.text = data[features];
    _coolingMethod.text = data[coolingMethod];
    _fromFactor.text = data[formFactor];
    _wattage.text = data[wattage];
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
        appBar: AppBar(surfaceTintColor: Colors.white),
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text('Update PSU', style: CustomText.title),
                          h30,
                          AdminUiHelper.customImageBox(() {
                            pickImage();
                          }, imageurl: imageurl),
                          h30,
                          Form(
                              key: formkey,
                              child: Column(children: [
                                AdminUi.admTextField(
                                    label: 'Product Name',
                                    textcontroller: _productName),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Model Name',
                                    textcontroller: _modelName),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Wattage (W)',
                                    textcontroller: _wattage),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Manufacturer',
                                    textcontroller: _manufacturer),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Old Price',
                                    textcontroller: _oldPrice),
                                h10,
                                AdminUi.admTextField(
                                    label: 'New Price',
                                    textcontroller: _newPrice),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Product Dimensions',
                                    textcontroller: _productDimension),
                                h10,
                                AdminUi.featuresTextfield(
                                    label: 'Features',
                                    textcontroller: _specialFeatures),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Cooling Method',
                                    textcontroller: _coolingMethod),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Form Factor',
                                    textcontroller: _fromFactor),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Country', textcontroller: _country),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Item Weight',
                                    textcontroller: _itemWeight),
                                h10,
                                AdminUi.admTextField(
                                    label: 'Warranty',
                                    textcontroller: _warranty),
                                h10,
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                              ])),
                          h30,
                          AdminUiHelper.customButton(context, () {
                            if (formkey.currentState!.validate()) {
                              Navigator.pop(context);
                              updateData();
                              AdminUiHelper.customSnackbar(
                                  context, 'Item Updated Successfully !');
                            }
                          }, text: 'Save'),
                          h30
                        ]))))));
  }
}
