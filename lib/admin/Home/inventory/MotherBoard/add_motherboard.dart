import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class ScreenAddMotherboard extends StatefulWidget {
  const ScreenAddMotherboard({super.key});

  @override
  State<ScreenAddMotherboard> createState() => __ScreenAddMotherboardState();
}

class __ScreenAddMotherboardState extends State<ScreenAddMotherboard> {
  final _formkey = GlobalKey<FormState>();
  final ramSlots = TextEditingController();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final manufacturer = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _modelName = TextEditingController();
  final _productDimension = TextEditingController();
  final _slots = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _ramType = TextEditingController();
  final ramMax = TextEditingController();
  final _processorSocket = TextEditingController();
  final _ssdType = TextEditingController();
  final ports = TextEditingController();
  final maxClock = TextEditingController();
  final wattage = TextEditingController();
  final _formFactor = TextEditingController();
  final _country = TextEditingController();
  final _itemWeight = TextEditingController();
  final _warranty = TextEditingController();
  String idnum = DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
  late String imageurl = '';
  String? selectedCategory;
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedBoard;
  String? selectedRamSpeed;
  String? selectedSocket;
  String? selectedRam;
  String? selectedSsd;
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
        FirebaseStorage.instance.ref().child('Motherboard/${image.name}');
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
      'maxclock': maxClock.text,
      'model': _modelName.text,
      'manufacturer': manufacturer.text,
      'processorsocket': _processorSocket.text,
      'ramType': _ramType.text,
      'ramsize': ramMax.text,
      'ramslots': ramSlots.text,
      'ssdtype': _ssdType.text,
      'ssdslots': _slots.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'productdimension': _productDimension.text,
      'features': _specialFeatures.text,
      'ports': ports.text,
      'wattage': wattage.text,
      'formfactor': _formFactor.text,
      'country': _country.text,
      'itemweight': _itemWeight.text,
      'warranty': _warranty.text,
    };
    FirebaseFirestore.instance.collection('motherboard').doc(idnum).set(data);
    setState(() {
      _productCategory.clear();
      imageurl = '';
      _productName.clear();
      maxClock.clear();
      _modelName.clear();
      manufacturer.clear();
      _processorSocket.clear();
      _ramType.clear();
      ramMax.clear();
      ramSlots.clear();
      _ssdType.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _productDimension.clear();
      _slots.clear();
      _specialFeatures.clear();
      ports.clear();
      wattage.clear();
      _formFactor.clear();
      _country.clear();
      _itemWeight.clear();
      _warranty.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('motherboarddetails')
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
                final motherboard = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toSet()
                    .toList();
                final clockSpeed = snapshot.data!.docs
                    .map((doc) => doc['maxclockspeed'] as String)
                    .toSet()
                    .toList();

                final model = snapshot.data!.docs
                    .map((doc) => doc['model'] as String)
                    .toSet()
                    .toList();
                final socket = snapshot.data!.docs
                    .map((doc) => doc['socket'] as String)
                    .toSet()
                    .toList();
                final ram = snapshot.data!.docs
                    .map((doc) => doc['ram'] as String)
                    .toSet()
                    .toList();
                final manufactured = snapshot.data!.docs
                    .map((doc) => doc['manufacturer'] as String)
                    .toSet()
                    .toList();
                final ssd = snapshot.data!.docs
                    .map((doc) => doc['ssd'] as String)
                    .toSet()
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('MotherBoard', style: CustomText.title),
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
                                  label: const Text('Select Category',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _productCategory,
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
                                  label: const Text('Select Motherboard',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _productName,
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
                                      selectedBoard = value;
                                    });
                                  },
                                  dropdownMenuEntries: motherboard
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select Clock Speed',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: maxClock,
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
                                      selectedRamSpeed = value;
                                    });
                                  },
                                  dropdownMenuEntries: clockSpeed
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
                                  controller: _modelName,
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
                                  label: const Text('Select Manufacturer',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: manufacturer,
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
                                      selectedManufacturer = value;
                                    });
                                  },
                                  dropdownMenuEntries: manufactured
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select Socket Type',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _processorSocket,
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
                                      selectedSocket = value;
                                    });
                                  },
                                  dropdownMenuEntries: socket
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList()),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select Ram Type',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _ramType,
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
                              AdminUi.admTextField(
                                  label: 'RAM Maximum Size',
                                  textcontroller: ramMax),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'RAM Slots', textcontroller: ramSlots),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select Storage Type',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: _ssdType,
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
                              AdminUi.admTextField(
                                  label: 'SSD Slots', textcontroller: _slots),
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
                                  label: 'Product Dimensions',
                                  textcontroller: _productDimension),
                              const SizedBox(height: 10),
                              AdminUi.featuresTextfield(
                                  label: 'Ports', textcontroller: ports),
                              const SizedBox(height: 10),
                              AdminUi.featuresTextfield(
                                  label: 'Features',
                                  textcontroller: _specialFeatures),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Form Factor',
                                  textcontroller: _formFactor),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Power Consumption (W)',
                                  textcontroller: wattage),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: _country),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Weight',
                                  textcontroller: _itemWeight),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: _warranty),
                            ],
                          )),
                      const SizedBox(height: 30),
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
                );
              }),
        ),
      ),
    );
  }
}
