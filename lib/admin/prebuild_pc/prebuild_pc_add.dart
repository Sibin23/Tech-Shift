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

class ScreenPreBuild extends StatefulWidget {
  const ScreenPreBuild({super.key});

  @override
  State<ScreenPreBuild> createState() => __ScreenPreBuildStateState();
}

class __ScreenPreBuildStateState extends State<ScreenPreBuild> {
  final _formkey = GlobalKey<FormState>();
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
  bool isNew = false;
  bool isPopular = false;
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

  Future submitData() async {
    final data = {
      uniqueId: idnum,
      category: preBuild,
      itemImage: imageurl.toString(),
      name: _case.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      processor: _processor.text,
      motherboard: _motherBoard.text,
      ram: _ram.text,
      ssd: _ssd.text,
      expStorage: _expandableStorage.text,
      gpu: _gpu.text,
      cooler: _cooler.text,
      features: _specialFeatures.text,
      psu: _psu.text,
      cabinet: _case.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular
    };
    final item = {
      itemImage: imageurl,
      name: _case.text,
      uniqueId: idnum,
      category: preBuild,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(preBuild).doc(idnum).set(data);
    setState(() {
      imageurl = '';
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
      isNew = false;
      isPopular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text("Pre - Build PC's", ),
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
                        label: 'Old Price', textcontroller: _oldPrice),
                    h10,
                    AdminUi.admTextField(
                        label: 'New Price', textcontroller: _newPrice),
                    h10,
                    AdminUi.admTextField(
                        label: 'Processor', textcontroller: _processor),
                    h10,
                    AdminUi.admTextField(
                        label: 'Motherboard', textcontroller: _motherBoard),
                    h10,
                    AdminUi.admTextField(label: 'Memory', textcontroller: _ram),
                    h10,
                    AdminUi.admTextField(
                        label: 'Storage', textcontroller: _ssd),
                    h10,
                    AdminUi.admTextField(
                        label: 'Expandable Storage',
                        textcontroller: _expandableStorage),
                    h10,
                    AdminUi.admTextField(label: 'GPU', textcontroller: _gpu),
                    h10,
                    AdminUi.admTextField(
                        label: 'Features', textcontroller: _specialFeatures),
                    h10,
                    AdminUi.admTextField(
                        label: 'PSU Certification', textcontroller: _psu),
                    h10,
                    AdminUi.admTextField(
                        label: 'Cooler', textcontroller: _cooler),
                    h10,
                    AdminUi.admTextField(label: 'Case', textcontroller: _case),
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
              h30
            ],
          ),
        ),
      )),
    );
  }
}
