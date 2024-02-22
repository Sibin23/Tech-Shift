import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddProcessor extends StatefulWidget {
  const ScreenAddProcessor({super.key});

  @override
  State<ScreenAddProcessor> createState() => _ScreenAddProcessorState();
}

class _ScreenAddProcessorState extends State<ScreenAddProcessor> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _cores = TextEditingController();
  final _threads = TextEditingController();
  final _socket = TextEditingController();
  final _speed = TextEditingController();
  final _cache = TextEditingController();
  final _integratedGraphics = TextEditingController();
  final _includedCPUCooler = TextEditingController();
  final _unlocked = TextEditingController();
  final _tdp = TextEditingController();
  // add image
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

  // add to firefase
  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Processor/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return imageurl = downloadUrl;
  }
  // submin function

  Future submitData() async {
    final data = {
      'categoryid': _productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': _productName.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'amd5': amd5,
      'amd7': amd7,
      '12thgen': intel12th,
      '13thgen': intel13th,
      '14thgen': intel14th,
      'cores': _cores.text,
      'threads': _threads.text,
      'socket': _socket.text,
      'speed': _speed.text,
      'cache': _cache.text,
      'graphics': _integratedGraphics.text,
      'cooler': _includedCPUCooler.text,
      'tdp': _tdp.text,
      'newarrival': newArival,
    };
    FirebaseFirestore.instance
        .collection('processor')
        .doc(_productCategory.text.toLowerCase())
        .set(data);

    setState(() {
      _productCategory.clear();
      _productName.clear();
      _oldPrice.clear();
      _newPrice.clear();
      amd5 = false;
      amd7 = false;
      intel12th = false;
      intel13th = false;
      intel14th = false;
      newArival = false;
      _cores.clear();
      _threads.clear();
      _socket.clear();
      _speed.clear();
      _cache.clear();
      _integratedGraphics.clear();
      _includedCPUCooler.clear();
      _unlocked.clear();
      _tdp.clear();
      imageurl = '';
    });
  }

  //checked box
  static bool amd5 = false;
  static bool amd7 = false;
  static bool intel14th = false;
  static bool intel12th = false;
  static bool intel13th = false;
// new arrival
  static bool newArival = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Processor', style: CustomText.title),
                const SizedBox(height: 20),
                AdminUiHelper.customImageBox(() {
                  pickImage();
                },imageurl: imageurl),
                const SizedBox(height: 20),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        AdminUi.admTextField(
                            label: 'Product Category',
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
                        Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.36,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Series', style: CustomText.title2),
                                      Card(
                                        elevation: 0,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('AMD RYZEN',
                                                        style: CustomText
                                                            .categoryText),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Row(children: <Widget>[
                                                            Text('5000 Series',
                                                                style: CustomText
                                                                    .categoryTitleText),
                                                            const SizedBox(
                                                                width: 5),
                                                            Checkbox(
                                                                value: amd5,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    amd5 =
                                                                        value!;
                                                                  });
                                                                })
                                                          ]),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <Widget>[
                                                                Text(
                                                                    '7000 Series',
                                                                    style: CustomText
                                                                        .categoryTitleText),
                                                                Checkbox(
                                                                    value: amd7,
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        amd7 =
                                                                            value!;
                                                                      });
                                                                    })
                                                              ])
                                                        ])
                                                  ]))),
                                      Card(
                                        elevation: 0,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Intel',
                                                        style: CustomText
                                                            .categoryText),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(children: <Widget>[
                                                            const SizedBox(
                                                                width: 5),
                                                            Text('12th gen',
                                                                style: CustomText
                                                                    .categoryTitleText),
                                                            const SizedBox(
                                                                width: 5),
                                                            Checkbox(
                                                                value:
                                                                    intel12th,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    intel12th =
                                                                        value!;
                                                                  });
                                                                })
                                                          ]),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text('13th gen',
                                                                    style: CustomText
                                                                        .categoryTitleText),
                                                                Checkbox(
                                                                  value:
                                                                      intel13th,
                                                                  onChanged: (value) =>
                                                                      setState(() =>
                                                                          intel13th =
                                                                              value!),
                                                                )
                                                              ])
                                                        ]),
                                                    const SizedBox(height: 5),
                                                    Row(children: <Widget>[
                                                      const SizedBox(width: 5),
                                                      Text('14th gen',
                                                          style: CustomText
                                                              .categoryTitleText),
                                                      const SizedBox(width: 5),
                                                      Checkbox(
                                                          value: intel14th,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              intel14th =
                                                                  value!;
                                                            });
                                                          })
                                                    ])
                                                  ])))
                                    ]))),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Cores', textcontroller: _cores),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Threads', textcontroller: _threads),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Socket', textcontroller: _socket),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Speed', textcontroller: _speed),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Cache', textcontroller: _cache),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Integrated Graphics',
                            textcontroller: _integratedGraphics),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Included CPU Cooler',
                            textcontroller: _includedCPUCooler),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'Unlocked', textcontroller: _unlocked),
                        const SizedBox(height: 10),
                        AdminUi.admTextField(
                            label: 'TDP in (W)', textcontroller: _tdp),
                        const SizedBox(height: 10),
                      ],
                    )),
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
                          Text('New Arrival', style: CustomText.title3)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AdminUiHelper.customButton(context, () {
                  if (_formkey.currentState!.validate()) {
                    submitData();
                    AdminUiHelper.customSnackbar(context, 'Item Added Successfully !');
                  }
                }, text: 'Save'),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
