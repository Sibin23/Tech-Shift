import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class EditProcessor extends StatefulWidget {
  final String itemId;
  const EditProcessor({super.key, required this.itemId});

  @override
  State<EditProcessor> createState() => _EditProcessorState();
}

class _EditProcessorState extends State<EditProcessor> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  String? idnum;
  final _productName = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final manufacturer = TextEditingController();
  final _cores = TextEditingController();
  final _threads = TextEditingController();
  final _socket = TextEditingController();
  final _speed = TextEditingController();
  final _cache = TextEditingController();
  final dimension = TextEditingController();
  final weight = TextEditingController();
  final country = TextEditingController();
  final _integratedGraphics = TextEditingController();
  final _includedCPUCooler = TextEditingController();
  final _unlocked = TextEditingController();
  final _tdp = TextEditingController();
  final _warranty = TextEditingController();
  late String imageurl = '';
  String? selectedProcessor;
  String? selectedSpeed;
  String? selectedSocket;
  String? selectedThreads;
  String? selectedCores;
  String? selectedCategory;
  String? image = '';
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

  updateData() {
    FirebaseFirestore.instance
        .collection('processor')
        .doc(widget.itemId) // Use the itemId
        .update({
      'image': imageurl.toString(),
      'name': _productName.text,
      'idnum': idnum,
      'manufacturer': manufacturer.text,
      'category': _productCategory.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'cores': _cores.text,
      'threads': _threads.text,
      'socket': _socket.text,
      'speed': _speed.text,
      'productdimension': dimension.text,
      'itemweight': weight.text,
      'country': country.text,
      'cache': _cache.text,
      'graphics': _integratedGraphics.text.toUpperCase(),
      'cooler': _includedCPUCooler.text.toUpperCase(),
      'unlocked': _unlocked.text.toUpperCase(),
      'tdp': _tdp.text,
      'warranty': _warranty.text,
    });
    setState(() {
      imageurl = '';
      _productName.clear();
      _socket.clear();
      _cores.clear();
      _threads.clear();
      _speed.clear();
      _cache.clear();
      _oldPrice.clear();
      _newPrice.clear();
      country.clear();
      dimension.clear();
      weight.clear();
      manufacturer.clear();
      _integratedGraphics.clear();
      _includedCPUCooler.clear();
      _unlocked.clear();
      _tdp.clear();
      _warranty.clear();
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('processor')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        _productName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        idnum = data['idnum'];
        _productCategory.text = data['category'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _cores.text = data['cores'];
        _threads.text = data['threads'];
        _cache.text = data['cache'];
        _socket.text = data['socket'];
        dimension.text = data['productdimension'];
        country.text = data['country'];
        weight.text = data['itemweight'];
        manufacturer.text = data['manufacturer'];
        _speed.text = data['speed'];
        _integratedGraphics.text = data['graphics'];
        _includedCPUCooler.text = data['cooler'];
        _unlocked.text = data['unlocked'];
        _tdp.text = data['tdp'];
        _warranty.text = data['warranty'];
      }
    });
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
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('cpudetails')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            const Center(
                                child: CircularProgressIndicator(
                                    color: CustomColors.appTheme));
                          }
                          final category = snapshot.data!.docs
                              .map((doc) => doc['category'] as String)
                              .toSet()
                              .toList();
                          final processor = snapshot.data!.docs
                              .map((doc) => doc['name'] as String)
                              .toSet()
                              .toList();
                          final sockets = snapshot.data!.docs
                              .map((doc) => doc['socket'] as String)
                              .toSet()
                              .toList();
                          final cores = snapshot.data!.docs
                              .map((doc) => doc['cores'] as String)
                              .toSet()
                              .toList();
                          final threads = snapshot.data!.docs
                              .map((doc) => doc['threads'] as String)
                              .toSet()
                              .toList();
                          final speeds = snapshot.data!.docs
                              .map((doc) => doc['speed'] as String)
                              .toSet()
                              .toList();
                          return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Update Processor',
                                        style: CustomText.title),
                                    const SizedBox(height: 20),
                                    AdminUiHelper.customImageBox(() {
                                      pickImage();
                                    }, imageurl: imageurl),
                                    const SizedBox(height: 20),
                                    Form(
                                        key: _formkey,
                                        child: Column(
                                          children: [
                                            DropdownMenu<String>(
                                                controller: _productCategory,
                                                menuStyle: const MenuStyle(
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white)),
                                                hintText: 'Select Category',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .93,
                                                menuHeight: 300,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        hintStyle: const TextStyle(
                                                            color:
                                                                CustomColors
                                                                    .appTheme),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                onSelected: (value) {
                                                  setState(() {
                                                    selectedCategory = value;
                                                  });
                                                },
                                                dropdownMenuEntries: category
                                                    .map<DropdownMenuEntry<String>>(
                                                        (String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()),
                                            const SizedBox(height: 10),
                                            DropdownMenu<String>(
                                                controller: _productName,
                                                menuStyle: const MenuStyle(
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white)),
                                                hintText: 'Select Processor',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .93,
                                                menuHeight: 300,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        hintStyle: const TextStyle(
                                                            color:
                                                                CustomColors
                                                                    .appTheme),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                onSelected: (value) {
                                                  setState(() {
                                                    selectedProcessor = value;
                                                  });
                                                },
                                                dropdownMenuEntries: processor
                                                    .map<DropdownMenuEntry<String>>(
                                                        (String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()),
                                            const SizedBox(height: 10),
                                            DropdownMenu<String>(
                                                controller: _socket,
                                                menuStyle: const MenuStyle(
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white)),
                                                hintText: 'Select Socket',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .93,
                                                menuHeight: 300,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        hintStyle: const TextStyle(
                                                            color:
                                                                CustomColors
                                                                    .appTheme),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                onSelected: (value) {
                                                  setState(() {
                                                    selectedSocket = value;
                                                  });
                                                },
                                                dropdownMenuEntries: sockets
                                                    .map<DropdownMenuEntry<String>>(
                                                        (String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()),
                                            const SizedBox(height: 10),
                                            DropdownMenu<String>(
                                                controller: _cores,
                                                menuStyle: const MenuStyle(
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white)),
                                                hintText: 'Select Cores',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .93,
                                                menuHeight: 300,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        hintStyle: const TextStyle(
                                                            color:
                                                                CustomColors
                                                                    .appTheme),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                onSelected: (value) {
                                                  setState(() {
                                                    selectedCores = value;
                                                  });
                                                },
                                                dropdownMenuEntries: cores
                                                    .map<DropdownMenuEntry<String>>(
                                                        (String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()),
                                            const SizedBox(height: 10),
                                            DropdownMenu<String>(
                                                controller: _threads,
                                                menuStyle: const MenuStyle(
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white)),
                                                hintText: 'Select Threads',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .93,
                                                menuHeight: 300,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        hintStyle: const TextStyle(
                                                            color:
                                                                CustomColors
                                                                    .appTheme),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                onSelected: (value) {
                                                  setState(() {
                                                    selectedThreads = value;
                                                  });
                                                },
                                                dropdownMenuEntries: threads
                                                    .map<DropdownMenuEntry<String>>(
                                                        (String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()),
                                            const SizedBox(height: 10),
                                            DropdownMenu<String>(
                                                controller: _speed,
                                                menuStyle: const MenuStyle(
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white)),
                                                hintText: 'Select Clock Speed',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .93,
                                                menuHeight: 300,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        hintStyle: const TextStyle(
                                                            color:
                                                                CustomColors
                                                                    .appTheme),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                onSelected: (value) {
                                                  setState(() {
                                                    selectedSpeed = value;
                                                  });
                                                },
                                                dropdownMenuEntries: speeds
                                                    .map<DropdownMenuEntry<String>>(
                                                        (String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()),
                                            AdminUi.space,
                                            AdminUi.admTextField(
                                                label: 'Manufacturer',
                                                textcontroller: manufacturer),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'Old Price',
                                                textcontroller: _oldPrice),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'New Price',
                                                textcontroller: _newPrice),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'Cache',
                                                textcontroller: _cache),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'Integrated Graphics',
                                                textcontroller:
                                                    _integratedGraphics),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'Included CPU Cooler',
                                                textcontroller:
                                                    _includedCPUCooler),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'Unlocked',
                                                textcontroller: _unlocked),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'TDP in (W)',
                                                textcontroller: _tdp),
                                            const SizedBox(height: 10),
                                            AdminUi.admTextField(
                                                label: 'Warranty',
                                                textcontroller: _warranty),
                                          ],
                                        )),
                                    const SizedBox(height: 30),
                                    AdminUiHelper.customButton(context, () {
                                      if (_formkey.currentState!.validate()) {
                                        Navigator.pop(context);
                                        updateData();
                                        AdminUiHelper.customSnackbar(context,
                                            'Item Added Successfully !');
                                      }
                                    }, text: 'Save'),
                                    const SizedBox(height: 40)
                                  ]));
                        })))));
  }
}
