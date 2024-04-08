import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ScreenPreBuild extends StatefulWidget {
  const ScreenPreBuild({super.key});

  @override
  State<ScreenPreBuild> createState() => __ScreenPreBuildStateState();
}

class __ScreenPreBuildStateState extends State<ScreenPreBuild> {
  final _formkey = GlobalKey<FormState>();
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
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
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
        FirebaseStorage.instance.ref().child('PreBuild/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'idnum': idnum,
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
        .doc(idnum)
        .set(data);
    setState(() {
      _productCategory.clear();
      imageurl = '';
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
    const space = SizedBox(height: 10);
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
                    
                    AdminUi.admTextField(
                        label: 'Category Name',
                        textcontroller: _productCategory),
                    space,
                    AdminUi.admTextField(
                        label: 'Product Name',
                        textcontroller: _productName),
                    space,
                    AdminUi.admTextField(
                        label: 'Old Price', textcontroller: _oldPrice),
                    space,
                    AdminUi.admTextField(
                        label: 'New Price', textcontroller: _newPrice),
                    space,
                    AdminUi.admTextField(
                        label: 'Processor', textcontroller: _processor),
                    space,
                    AdminUi.admTextField(
                        label: 'Motherboard', textcontroller: _motherBoard),
                    space,
                    AdminUi.admTextField(
                        label: 'Memory', textcontroller: _ram),
                    space,
                    AdminUi.admTextField(
                        label: 'Storage', textcontroller: _ssd),
                    space,
                    AdminUi.admTextField(
                        label: 'Expandable Storage',
                        textcontroller: _expandableStorage),
                    space,
                    AdminUi.admTextField(
                        label: 'GPU', textcontroller: _gpu),
                    space,
                    
                    AdminUi.admTextField(
                        label: 'Features',
                        textcontroller: _specialFeatures),
                    space,
                    AdminUi.admTextField(
                        label: 'PSU Certification', textcontroller: _psu),
                    space,
                    AdminUi.admTextField(label: 'Cooler', textcontroller: _cooler),
                    space,
                    AdminUi.admTextField(
                        label: 'Case', textcontroller: _case),
                    space,
                    AdminUi.admTextField(
                        label: 'Warranty', textcontroller: _warranty),
                    const SizedBox(height: 30),
                  ])),
              AdminUiHelper.customButton(context, () {
                if (_formkey.currentState!.validate()) {
                  Navigator.pop(context);
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
