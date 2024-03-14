import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddSsd extends StatefulWidget {
  const ScreenAddSsd({super.key});

  @override
  State<ScreenAddSsd> createState() => _ScreenAddSsdState();
}

class _ScreenAddSsdState extends State<ScreenAddSsd> {
  final _formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  final productCategory = TextEditingController();
  final productName = TextEditingController();
  final manufacturer = TextEditingController();
  final oldPrice = TextEditingController();
  final newPrice = TextEditingController();
  final modelName = TextEditingController();
  final gen = TextEditingController();
  final productDimension = TextEditingController();
  final maxStorage = TextEditingController();
  final interface = TextEditingController();
  final transferSpeed = TextEditingController();
  final connector = TextEditingController();
  final fromFactor = TextEditingController();
  final wattage = TextEditingController();
  final country = TextEditingController();
  final itemWeight = TextEditingController();
  final warranty = TextEditingController();
  String? selectedCategory;
  String? selectedSsd;
  String? selectedModel;
  String? selectedSpeed;
  String? selectedGen;
  String? selcetedStorage;
  String? imageurl = '';
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
        FirebaseStorage.instance.ref().child('SSD/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  // submit
  Future submitData() async {
    final data = {
      'category': productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'idnum': idNum.text,
      'name': productName.text,
      'manufacturer': manufacturer.text,
      'oldprice': oldPrice.text,
      'newprice': newPrice.text,
      'model': modelName.text,
      'gentype': gen.text,
      'productdimension': productDimension.text,
      'storage': maxStorage.text,
      'interface': interface.text,
      'transferspeed': transferSpeed.text,
      'connectivity': connector.text,
      'formfactor': fromFactor.text,
      'wattage': wattage.text,
      'country': country.text,
      'itemweight': itemWeight.text,
      'warranty': warranty.text,
    };
    FirebaseFirestore.instance
        .collection('ssd')
        .doc(idNum.text.toLowerCase())
        .set(data);
    setState(() {
      productCategory.clear();
      imageurl = '';
      idNum.clear();
      productName.clear();
      manufacturer.clear();
      oldPrice.clear();
      newPrice.clear();
      modelName.clear();
      gen.clear();
      productDimension.clear();
      maxStorage.clear();
      interface.clear();
      transferSpeed.clear();
      connector.clear();
      fromFactor.clear();
      wattage.clear();
      country.clear();
      itemWeight.clear();
      warranty.clear();
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('ssddetails')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final category = snapshot.data!.docs
                        .map((doc) => doc['category'] as String)
                        .toSet()
                        .toList();
                    final ssd = snapshot.data!.docs
                        .map((doc) => doc['name'] as String)
                        .toSet()
                        .toList();
                    final model = snapshot.data!.docs
                        .map((doc) => doc['model'] as String)
                        .toSet()
                        .toList();
                    final gemtype = snapshot.data!.docs
                        .map((doc) => doc['gentype'] as String)
                        .toSet()
                        .toList();
                    final speeds = snapshot.data!.docs
                        .map((doc) => doc['speed'] as String)
                        .toSet()
                        .toList();
                    final storage = snapshot.data!.docs
                        .map((doc) => doc['storage'] as String)
                        .toSet()
                        .toList();
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text('Solid State Drive', style: CustomText.title),
                          const SizedBox(height: 20),
                          AdminUiHelper.customImageBox(() {
                            pickImage();
                          }, imageurl: imageurl),
                          const SizedBox(height: 20),
                          Form(
                              key: _formkey,
                              child: Column(children: [
                                AdminUi.admTextField(
                                    label: 'Unique ID', textcontroller: idNum),
                                const SizedBox(height: 10),
                                DropdownMenu<String>(
                                    label: const Text('Select Category',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: productCategory,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                const SizedBox(height: 10),
                                DropdownMenu<String>(
                                    label: const Text('Select SSD',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: productName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedSsd = value;
                                      });
                                    },
                                    dropdownMenuEntries: ssd
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                const SizedBox(height: 10),
                                DropdownMenu<String>(
                                    label: const Text('Select Model',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: modelName,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedModel = value;
                                      });
                                    },
                                    dropdownMenuEntries: model
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                const SizedBox(height: 10),
                                DropdownMenu<String>(
                                    label: const Text('Select Gen Type',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: gen,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedGen = value;
                                      });
                                    },
                                    dropdownMenuEntries: gemtype
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                const SizedBox(height: 10),
                                DropdownMenu<String>(
                                    label: const Text('Select Speed',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: transferSpeed,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                const SizedBox(height: 10),
                                DropdownMenu<String>(
                                    label: const Text('Select Storage Capacity',
                                        style: TextStyle(
                                            color: CustomColors.appTheme)),
                                    controller: maxStorage,
                                    menuStyle: const MenuStyle(
                                        surfaceTintColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    width:
                                        MediaQuery.of(context).size.width * .93,
                                    menuHeight: 300,
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        fillColor: Colors.white,
                                        filled: true),
                                    onSelected: (value) {
                                      setState(() {
                                        selcetedStorage = value;
                                      });
                                    },
                                    dropdownMenuEntries: storage
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList()),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Manufacturer',
                                    textcontroller: manufacturer),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Old Price',
                                    textcontroller: oldPrice),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'New Price',
                                    textcontroller: newPrice),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Product Dimensions',
                                    textcontroller: productDimension),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Interface',
                                    textcontroller: interface),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Connectivity',
                                    textcontroller: connector),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Form Factor',
                                    textcontroller: fromFactor),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Wattage', textcontroller: wattage),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Country', textcontroller: country),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Item Weight',
                                    textcontroller: itemWeight),
                                const SizedBox(height: 10),
                                AdminUi.admTextField(
                                    label: 'Warranty',
                                    textcontroller: warranty),
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
                        ]));
                  }))),
    );
  }
}
