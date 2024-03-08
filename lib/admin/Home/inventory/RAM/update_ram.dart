import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateRam extends StatefulWidget {
  final String itemId;
  const UpdateRam({super.key, required this.itemId});

  @override
  State<UpdateRam> createState() => _UpdateRamState();
}

class _UpdateRamState extends State<UpdateRam> {
  final formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  final productCategory = TextEditingController();
  final productName = TextEditingController();
  final manufacturer = TextEditingController();
  final oldPrice = TextEditingController();
  final newPrice = TextEditingController();
  final modelName = TextEditingController();
  final productDimension = TextEditingController();
  final ramSize = TextEditingController();
  final ramType = TextEditingController();
  final clockSpeed = TextEditingController();
  final voltage = TextEditingController();
  final formFactor = TextEditingController();
  final country = TextEditingController();
  final itemWeight = TextEditingController();
  final warranty = TextEditingController();
  String? image;
  late String imageurl = '';
  String? selectedCategory;
  String? selectedRam;
  String? selectedModel;
  String? selectedRamType;
  String? selectedSpeed;
  String? selectedRamSize;
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
        FirebaseStorage.instance.ref().child('RAM/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance.collection('ram').doc(widget.itemId).update({
      'idnum': idNum.text.trim(),
      'category': productCategory.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': productName.text,
      'manufacturer': manufacturer.text,
      'oldprice': oldPrice.text,
      'newprice': newPrice.text,
      'model': modelName.text,
      'productdimension': productDimension.text,
      'ramsize': ramSize.text,
      'ramtype': ramType.text,
      'clockspeed': clockSpeed.text,
      'voltage': voltage.text,
      'formfactor': formFactor.text,
      'country': country.text,
      'itemweight': itemWeight.text,
      'warranty': warranty.text,
    });
    setState(() {
      productCategory.clear();
      idNum.clear();
      imageurl = '';
      productName.clear();
      manufacturer.clear();
      oldPrice.clear();
      newPrice.clear();
      modelName.clear();
      productDimension.clear();
      ramSize.clear();
      ramType.clear();
      clockSpeed.clear();
      voltage.clear();
      formFactor.clear();
      country.clear();
      itemWeight.clear();
      warranty.clear();
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('ram')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;

        imageurl = data['image'];
        setState(() {
          image = imageurl;
        });
        productName.text = data['name'];
        productCategory.text = data['category'];
        idNum.text = data['idnum'];
        manufacturer.text = data['manufacturer'];
        oldPrice.text = data['oldprice'];
        newPrice.text = data['newprice'];
        modelName.text = data['model'];
        ramSize.text = data['ramsize'];
        productDimension.text = data['productdimension'];
        ramType.text = data['ramtype'];
        clockSpeed.text = data['clockspeed'];
        voltage.text = data['voltage'];
        formFactor.text = data['formfactor'];
        country.text = data['country'];
        itemWeight.text = data['itemweight'];
        warranty.text = data['warranty'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('ram').snapshots(),
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
                final ram = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final model = snapshot.data!.docs
                    .map((doc) => doc['model'] as String)
                    .toSet()
                    .toList();
                final type = snapshot.data!.docs
                    .map((doc) => doc['ramtype'] as String)
                    .toSet()
                    .toList();
                final speeds = snapshot.data!.docs
                    .map((doc) => doc['clockspeed'] as String)
                    .toSet()
                    .toList();
                final size = snapshot.data!.docs
                    .map((doc) => doc['ramsize'] as String)
                    .toSet()
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Memory RAM', style: CustomText.title),
                      const SizedBox(height: 20),
                      AdminUiHelper.customImageBox(() {
                        pickImage();
                      }, imageurl: imageurl),
                      const SizedBox(height: 20),
                      Form(
                          key: formkey,
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
                                        MaterialStatePropertyAll(Colors.white)),
                                width: MediaQuery.of(context).size.width * .93,
                                menuHeight: 300,
                                inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
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
                                label: const Text('Select RAM',
                                    style: TextStyle(
                                        color: CustomColors.appTheme)),
                                controller: productName,
                                menuStyle: const MenuStyle(
                                    surfaceTintColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                width: MediaQuery.of(context).size.width * .93,
                                menuHeight: 300,
                                inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true),
                                onSelected: (value) {
                                  setState(() {
                                    selectedRam = value;
                                  });
                                },
                                dropdownMenuEntries: ram
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
                                        MaterialStatePropertyAll(Colors.white)),
                                width: MediaQuery.of(context).size.width * .93,
                                menuHeight: 300,
                                inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
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
                                label: const Text('Select RAM Type',
                                    style: TextStyle(
                                        color: CustomColors.appTheme)),
                                controller: ramType,
                                menuStyle: const MenuStyle(
                                    surfaceTintColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                width: MediaQuery.of(context).size.width * .93,
                                menuHeight: 300,
                                inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true),
                                onSelected: (value) {
                                  setState(() {
                                    selectedRamType = value;
                                  });
                                },
                                dropdownMenuEntries: type
                                    .map<DropdownMenuEntry<String>>(
                                        (String value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }).toList()),
                            const SizedBox(height: 10),
                            DropdownMenu<String>(
                                label: const Text('Select RAM Size',
                                    style: TextStyle(
                                        color: CustomColors.appTheme)),
                                controller: ramSize,
                                menuStyle: const MenuStyle(
                                    surfaceTintColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                width: MediaQuery.of(context).size.width * .93,
                                menuHeight: 300,
                                inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true),
                                onSelected: (value) {
                                  setState(() {
                                    selectedRamSize = value;
                                  });
                                },
                                dropdownMenuEntries: size
                                    .map<DropdownMenuEntry<String>>(
                                        (String value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }).toList()),
                            const SizedBox(height: 10),
                            DropdownMenu<String>(
                                label: const Text('Select RAM Speed',
                                    style: TextStyle(
                                        color: CustomColors.appTheme)),
                                controller: clockSpeed,
                                menuStyle: const MenuStyle(
                                    surfaceTintColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                width: MediaQuery.of(context).size.width * .93,
                                menuHeight: 300,
                                inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
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
                                label: 'Product Dimensions',
                                textcontroller: productDimension),
                            const SizedBox(height: 10),
                            AdminUi.admTextField(
                                label: 'Voltage', textcontroller: voltage),
                            const SizedBox(height: 10),
                            AdminUi.admTextField(
                                label: 'Form Factor',
                                textcontroller: formFactor),
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
                          ])), // Textfromfield
                      AdminUiHelper.customButton(context, () {
                        if (formkey.currentState!.validate()) {
                          Navigator.pop(context);
                          updateData();
                          AdminUiHelper.customSnackbar(
                              context, 'Item Updated Successfully !');
                        }
                      }, text: 'Save'),
                      const SizedBox(height: 30)
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
