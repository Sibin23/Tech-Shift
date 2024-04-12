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

class ScreenAddProcessor extends StatefulWidget {
  const ScreenAddProcessor({
    super.key,
  });

  @override
  State<ScreenAddProcessor> createState() => _ScreenAddProcessorState();
}

class _ScreenAddProcessorState extends State<ScreenAddProcessor> {
  final _formkey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _cores = TextEditingController();
  final _manufacturer = TextEditingController();
  final _threads = TextEditingController();
  final _socket = TextEditingController();
  final _speed = TextEditingController();
  final _dimension = TextEditingController();
  final _country = TextEditingController();
  final _weight = TextEditingController();
  final _cache = TextEditingController();
  final _integratedGraphics = TextEditingController();
  final _includedCPUCooler = TextEditingController();
  final _unlocked = TextEditingController();
  final _tdp = TextEditingController();
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
        FirebaseStorage.instance.ref().child('Processor/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return imageurl = downloadUrl;
  }

  Future submitData() async {
    final data = {
      itemImage: imageurl.toString(),
      uniqueId: idnum,
      category: processor,
      name: _productName.text,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
      manufacturer: _manufacturer.text,
      cores: _cores.text,
      threads: _threads.text,
      socket: _socket.text.trim().toUpperCase(),
      speed: _speed.text,
      dimension: _dimension.text,
      weight: _weight.text,
      country: _country.text,
      cache: _cache.text,
      graphics: _integratedGraphics.text.toUpperCase(),
      integratedCooler: _includedCPUCooler.text.toUpperCase(),
      unlocked: _unlocked.text.toUpperCase(),
      tdp: _tdp.text,
      warranty: _warranty.text,
      newArival: isNew,
      popular: isPopular,
    };
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: idnum,
      category: processor,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(idnum).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(idnum).set(item);
    }
    FirebaseFirestore.instance.collection(processor).doc(idnum).set(data);

    setState(() {
      _productName.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _manufacturer.clear();
      _cores.clear();
      _threads.clear();
      _socket.clear();
      _speed.clear();
      _dimension.clear();
      _weight.clear();
      _country.clear();
      _cache.clear();
      _integratedGraphics.clear();
      _includedCPUCooler.clear();
      _unlocked.clear();
      _tdp.clear();
      _warranty.clear();
      imageurl = '';
      isNew = false;
      isPopular = false;
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Add Processor', style: CustomText.title),
                h30,
                AdminUiHelper.customImageBox(() {
                  pickImage();
                }, imageurl: imageurl),
                h30,
                Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdminUi.admTextField(
                            label: 'Product Name',
                            textcontroller: _productName),
                        h10,
                        AdminUi.admTextField(
                            label: 'Socket', textcontroller: _socket),
                        h10,
                        AdminUi.admTextField(
                            label: 'Cores', textcontroller: _cores),
                        h10,
                        AdminUi.admTextField(
                            label: 'Threads', textcontroller: _threads),
                        h10,
                        AdminUi.admTextField(
                            label: 'Clock Speed', textcontroller: _speed),
                        h10,
                        AdminUi.admTextField(
                            label: 'Manufacturer',
                            textcontroller: _manufacturer),
                        h10,
                        AdminUi.admTextField(
                            label: 'Old Price', textcontroller: _oldPrice),
                        h10,
                        AdminUi.admTextField(
                            label: 'New Price', textcontroller: _newPrice),
                        h10,
                        AdminUi.admTextField(
                            label: 'Cache', textcontroller: _cache),
                        h10,
                        AdminUi.admTextField(
                            label: 'Integrated Graphics',
                            textcontroller: _integratedGraphics),
                        h10,
                        AdminUi.admTextField(
                            label: 'Included CPU Cooler',
                            textcontroller: _includedCPUCooler),
                        h10,
                        AdminUi.admTextField(
                            label: 'Unlocked', textcontroller: _unlocked),
                        h10,
                        AdminUi.admTextField(
                            label: 'TDP in (W)', textcontroller: _tdp),
                        h10,
                        AdminUi.admTextField(
                            label: 'Product Dimension',
                            textcontroller: _dimension),
                        h10,
                        AdminUi.admTextField(
                            label: 'Item Weight', textcontroller: _weight),
                        h10,
                        AdminUi.admTextField(
                            label: 'Country of Origin',
                            textcontroller: _country),
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
                    submitData();
                    AdminUiHelper.customSnackbar(
                        context, 'Item Added Successfully !');
                  }
                }, text: 'Save'),
                h30
              ],
            ),
          ),
        ),
      ),
    );
  }
}
