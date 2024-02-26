import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenPreBuild extends StatefulWidget {
  const ScreenPreBuild({super.key});

  @override
  State<ScreenPreBuild> createState() => __ScreenPreBuildStateState();
}

class __ScreenPreBuildStateState extends State<ScreenPreBuild>
    with TickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  final _idNum = TextEditingController();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _processor = TextEditingController();
  final _motherBoard = TextEditingController();
  final _ram = TextEditingController();
  final _ssd = TextEditingController();
  final _expandableStorage = TextEditingController();
  final _gpu = TextEditingController();
  final _cooler = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _psu = TextEditingController();
  final _case = TextEditingController();
  final _warranty = TextEditingController();
  
 
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
        FirebaseStorage.instance.ref().child('PreBuild/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'idnum': _idNum.text,
      'category': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'processor': _processor.text,
      'motherboard': _motherBoard.text,
      'ram': _ram.text,
      'ssd': _ssd.text,
      'expstorage': _expandableStorage.text,
      'gpu': _gpu.text,
      'cooler': _cooler.text,
      'features': _specialFeatures.text,
      'psu': _psu.text,
      'case': _case.text,
      'warranty': _warranty.text,
    };
    FirebaseFirestore.instance
        .collection('prebuild')
        .doc(_idNum.text.toLowerCase())
        .set(data);
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _idNum.clear();
      _productName.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _processor.clear();
      _motherBoard.clear();
      _ram.clear();
      _ssd.clear();
      _expandableStorage.clear();
      _gpu.clear();
      _cooler.clear();
      _specialFeatures.clear();
      _psu.clear();
      _case.clear();
      _warranty.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        centerTitle: true,
        title: Text("Pre - Build PC's", style: CustomText.apptitle),
       
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AdminUiHelper.customImageBox(() {
                pickImage();
              }, imageurl: imageurl),
              const SizedBox(height: 20),
              Form(
                  key: _formkey,
                  child: Column(children: [
                    AdminUi.admTextField(label: 'Unique ID', textcontroller: _idNum),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Category Name',
                        textcontroller: _productCategory),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Product Name',
                        textcontroller: _productName),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Old Price', textcontroller: _oldPrice),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'New Price', textcontroller: _newPrice),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Processor', textcontroller: _processor),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Motherboard', textcontroller: _motherBoard),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Memory', textcontroller: _ram),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Storage', textcontroller: _ssd),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Expandable Storage',
                        textcontroller: _expandableStorage),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'GPU', textcontroller: _gpu),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Cooler', textcontroller: _cooler),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Features',
                        textcontroller: _specialFeatures),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'PSU Certification', textcontroller: _psu),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(label: 'Cooler', textcontroller: _cooler),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Case', textcontroller: _case),
                    const SizedBox(height: 10),
                    AdminUi.admTextField(
                        label: 'Warranty', textcontroller: _warranty),
                    const SizedBox(height: 30),
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
      )),
    );
  }
}
