import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddPsu extends StatefulWidget {
  const ScreenAddPsu({super.key});

  @override
  State<ScreenAddPsu> createState() => _ScreenAddPsuState();
}

class _ScreenAddPsuState extends State<ScreenAddPsu> {
  final formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  final productCategory = TextEditingController();
  final productName = TextEditingController();
  final manufacturer = TextEditingController();
  final oldPrice = TextEditingController();
  final newPrice = TextEditingController();
  final modelName = TextEditingController();
  final productDimension = TextEditingController();
  final specialFeatures = TextEditingController();
  final wattage = TextEditingController();
  final coolingMethod = TextEditingController();
  final fromFactor = TextEditingController();
  final country = TextEditingController();
  final itemWeight = TextEditingController();
  final warranty = TextEditingController();
  late String imageurl = '';
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

  Future submitData() async {
    final data = {
      'category': productCategory.text.toLowerCase(),
      'idnum': idNum.text.trim().toString(),
      'image': imageurl.toString(),
      'name': productName.text,
      'manufacturer': manufacturer.text,
      'oldprice': oldPrice.text,
      'newprice': newPrice.text,
      'model': modelName.text,
      'productdimension': productDimension.text,
      'features': specialFeatures.text,
      'coolingmethod': coolingMethod.text,
      'formfactor': fromFactor.text,
      'wattage': wattage.text,
      'country': country.text,
      'itemweight': itemWeight.text,
      'warranty': warranty.text,
    };
    FirebaseFirestore.instance
        .collection('psu')
        .doc(idNum.text.trim().toLowerCase())
        .set(data);
    setState(() {
      productCategory.clear();
      imageurl = '';
      productName.clear();
      manufacturer.clear();
      oldPrice.clear();
      newPrice.clear();
      modelName.clear();
      specialFeatures.clear();
      productDimension.clear();
      wattage.clear();
      coolingMethod.clear();
      fromFactor.clear();
      itemWeight.clear();
      warranty.clear();
    });
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
                        Text('PSU', style: CustomText.title),
                        const SizedBox(height: 20),
                        AdminUiHelper.customImageBox(() {
                          pickImage();
                        }, imageurl: imageurl),
                        const SizedBox(height: 20),
                        Form(
                            key: formkey,
                            child: Column(children: [
                              AdminUi.admTextField(label: 'Unique Id', textcontroller: idNum),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Category Name',
                                  textcontroller: productCategory),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Product Name',
                                  textcontroller: productName),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Manufacturer',
                                  textcontroller: manufacturer),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Old Price', textcontroller: oldPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'New Price', textcontroller: newPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Model Name',
                                  textcontroller: modelName),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Product Dimensions',
                                  textcontroller: productDimension),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Features',
                                  textcontroller: specialFeatures),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Wattage', textcontroller: wattage),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Cooling Method',
                                  textcontroller: coolingMethod),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Form Factor',
                                  textcontroller: fromFactor),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: country),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: itemWeight),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: warranty),
                              const SizedBox(height: 30),
                              
                            ])), // TextFormFeild
                        AdminUiHelper.customButton(context, () {
                          if (formkey.currentState!.validate()) {
                            submitData();
                            AdminUiHelper.customSnackbar(
                                context, 'Item Added Successfully !');
                          }
                        }, text: 'Save'),
                        const SizedBox(height: 30)
                      ]))))),
    );
  }
}
