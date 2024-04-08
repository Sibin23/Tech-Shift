import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class UpdateGpu extends StatefulWidget {
  final String itemId;
  const UpdateGpu({super.key, required this.itemId});

  @override
  State<UpdateGpu> createState() => _UpdateGpuState();
}

class _UpdateGpuState extends State<UpdateGpu> {
  final formkey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final gpuName = TextEditingController();
  final modelName = TextEditingController();
  final manufacturer = TextEditingController();
  final support = TextEditingController();
  final clockSpeed = TextEditingController();
  final oldPrice = TextEditingController();
  final newPrice = TextEditingController();
  final color = TextEditingController();
  final features = TextEditingController();
  final maxResolution = TextEditingController();
  final dimension = TextEditingController();
  final ramType = TextEditingController();
  final ramSize = TextEditingController();
  final recPsu = TextEditingController();
  final wattage = TextEditingController();
  final country = TextEditingController();
  final weight = TextEditingController();
  final warranty = TextEditingController();
  late String imageurl = '';
  String? image;
  String? selectedGpu;
  String? selectedCategory;
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedFeatureSprt;
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
        FirebaseStorage.instance.ref().child('Graphics Card/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('gpu')
        .doc(widget.itemId) 
        .update({
      'image': imageurl.toString(),
      'category': categoryName.text.trim(),
      'idnum': widget.itemId,
      'name': gpuName.text,
      'model': modelName.text,
      'manufacturer': manufacturer.text,
      'support': support.text,
      'speed': clockSpeed.text,
      'oldprice': oldPrice.text,
      'newprice': newPrice.text,
      'color': color.text,
      'features': features.text,
      'maxres': maxResolution.text,
      'productdimension': dimension.text,
      'ramtype': ramType.text,
      'ramsize': ramSize.text,
      'recpsu': recPsu.text,
      'wattage': wattage.text,
      'country': country.text,
      'itemweight': weight.text,
      'warranty': warranty.text,
    });
    setState(() {
      imageurl = '';
      categoryName.clear();
      gpuName.clear();
      modelName.clear();
      manufacturer.clear();
      support.clear();
      clockSpeed.clear();
      oldPrice.clear();
      newPrice.clear();
      color.clear();
      features.clear();
      maxResolution.clear();
      dimension.clear();
      ramType.clear();
      ramSize.clear();
      recPsu.clear();
      wattage.clear();
      country.clear();
      weight.clear();
      warranty.clear();
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('gpu')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        categoryName.text = data['category'];
        gpuName.text = data['name'];
        imageurl = data['image'];
        setState(() {
          image = imageurl;
        });
        oldPrice.text = data['oldprice'];
        newPrice.text = data['newprice'];
        modelName.text = data['model'];
        manufacturer.text = data['manufacturer'];
        support.text = data['support'];
        dimension.text = data['productdimension'];
        clockSpeed.text = data['speed'];
        color.text = data['color'];
        features.text = data['features'];
        maxResolution.text = data['maxres'];
        dimension.text = data['productdimension'];
        ramType.text = data['ramtype'];
        ramSize.text = data['ramsize'];
        recPsu.text = data['recpsu'];
        wattage.text = data['wattage'];
        country.text = data['country'];
        weight.text = data['itemweight'];
        warranty.text = data['warranty'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('gpu').snapshots(),
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
                final gpu = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final model = snapshot.data!.docs
                    .map((doc) => doc['model'] as String)
                    .toSet()
                    .toList();
                final manufactured = snapshot.data!.docs
                    .map((doc) => doc['manufacturer'] as String)
                    .toSet()
                    .toList();
                final supports = snapshot.data!.docs
                    .map((doc) => doc['support'] as String)
                    .toSet()
                    .toList();
                return SingleChildScrollView(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Text('GPU', style: CustomText.title),
                              const SizedBox(height: 20),
                              AdminUiHelper.customImageBox(() {
                                pickImage();
                              }, imageurl: imageurl),
                              const SizedBox(height: 20),
                              Form(
                                  key: formkey,
                                  child: Column(children: [
                                    
                                    
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Category',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: gpuName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Graphics Card',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: gpuName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedGpu = value;
                                          });
                                        },
                                        dropdownMenuEntries: gpu
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Model',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: modelName,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
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
                                    space,
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Manufacturer',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: manufacturer,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                hintStyle: const TextStyle(
                                                    color:
                                                        CustomColors.appTheme),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedManufacturer = value;
                                          });
                                        },
                                        dropdownMenuEntries: manufactured
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    DropdownMenu<String>(
                                        label: const Text(
                                          'Select Feature Supports',
                                          style: TextStyle(
                                              color: CustomColors.appTheme),
                                        ),
                                        controller: support,
                                        menuStyle: const MenuStyle(
                                            surfaceTintColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .93,
                                        menuHeight: 300,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fillColor: Colors.white,
                                                filled: true),
                                        onSelected: (value) {
                                          setState(() {
                                            selectedFeatureSprt = value;
                                          });
                                        },
                                        dropdownMenuEntries: supports
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList()),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Old Price',
                                        textcontroller: oldPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'New Price',
                                        textcontroller: newPrice),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Colour', textcontroller: color),
                                    space,
                                    AdminUi.featuresTextfield(
                                        label: 'Features',
                                        textcontroller: features),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Max Resolution',
                                        textcontroller: maxResolution),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Product Dimensions',
                                        textcontroller: dimension),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'RAM Type',
                                        textcontroller: ramType),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'RAM Size',
                                        textcontroller: ramSize),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Recomended PSU',
                                        textcontroller: recPsu),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Wattage',
                                        textcontroller: wattage),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Country',
                                        textcontroller: country),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Item Weight',
                                        textcontroller: weight),
                                    space,
                                    AdminUi.admTextField(
                                        label: 'Warranty',
                                        textcontroller: warranty)
                                  ])),
                              const SizedBox(height: 30),
                              AdminUiHelper.customButton(context, () {
                                if (formkey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  updateData();
                                  AdminUiHelper.customSnackbar(
                                      context, 'Item Updated Successfully !');
                                }
                              }, text: 'Save'),
                              const SizedBox(height: 30)
                            ]))));
              })),
    );
  }
}
