import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateMotherboard extends StatefulWidget {
  final String itemId;
  const UpdateMotherboard({super.key, required this.itemId});

  @override
  State<UpdateMotherboard> createState() => _UpdateMotherboardState();
}

class _UpdateMotherboardState extends State<UpdateMotherboard> {
  final _formkey = GlobalKey<FormState>();
  final idNum = TextEditingController();
  String? image;
  late String imageurl = '';
  final categoryName = TextEditingController();
  final itemName = TextEditingController();
  final maxClock = TextEditingController();
  final modelName = TextEditingController();
  final manufacturer = TextEditingController();
  final processorSocket = TextEditingController();
  final ramType = TextEditingController();
  final ramSize = TextEditingController();
  final ramSlots = TextEditingController();
  final ssdType = TextEditingController();
  final ssdSlots = TextEditingController();
  final oldPrice = TextEditingController();
  final newPrice = TextEditingController();
  final dimension = TextEditingController();
  final ports = TextEditingController();
  final features = TextEditingController();
  final wattage = TextEditingController();
  final formFactor = TextEditingController();
  final country = TextEditingController();
  final weight = TextEditingController();
  final warranty = TextEditingController();
  String? selectedCategory;
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedBoard;
  String? selectedRamSpeed;
  String? selectedSocket;
  String? selectedRam;
  String? selectedSsd;
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
        FirebaseStorage.instance.ref().child('Motherboard/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('motherboard')
        .doc(widget.itemId) // Use the itemId
        .update({
      'idnum': idNum.text,
      'category': categoryName.text.toLowerCase(),
      'image': imageurl.toString(),
      'name': itemName.text,
      'maxclock': maxClock.text,
      'model': modelName.text,
      'manufacturer': manufacturer.text,
      'processorsocket': processorSocket.text,
      'ramType': ramType.text,
      'ramsize': ramSize.text,
      'ramslots': ramSlots.text,
      'ssdtype': ssdType.text,
      'ssdslots': ssdSlots.text,
      'oldprice': oldPrice.text,
      'newprice': newPrice.text,
      'productdimension': dimension.text,
      'features': features.text,
      'ports': ports.text,
      'wattage': wattage.text,
      'formfactor': formFactor.text,
      'country': country.text,
      'itemweight': weight.text,
      'warranty': warranty.text,
    });
    setState(() {
      idNum.clear();
      categoryName.clear();
      imageurl = '';
      itemName.clear();
      maxClock.clear();
      modelName.clear();
      manufacturer.clear();
      processorSocket.clear();
      ramType.clear();
      ramSize.clear();
      ramSlots.clear();
      ssdType.clear();
      ssdSlots.clear();
      oldPrice.clear();
      newPrice.clear();
      dimension.clear();
      features.clear();
      ports.clear();
      wattage.clear();
      formFactor.clear();
      country.clear();
      weight.clear();
      warranty.clear();
    });
  }

  @override
  void initState() {
    print(widget.itemId);
    FirebaseFirestore.instance
        .collection('motherboard')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        itemName.text = data['name'];
        setState(() {
          image = imageurl;
        });
        imageurl = data['image'];
        idNum.text = data['idnum'];
        categoryName.text = data['category'];
        manufacturer.text = data['manufacturer'];
        oldPrice.text = data['oldprice'];
        newPrice.text = data['newprice'];
        modelName.text = data['model'];
        ramSize.text = data['ramsize'];
        dimension.text = data['productdimension'];
        ssdSlots.text = data['ssdslots'];
        ports.text = data['ports'];
        features.text = data['features'];
        ramType.text = data['ramType'];
        ramSlots.text = data['ramslots'];
        processorSocket.text = data['processorsocket'];
        ssdType.text = data['ssdtype'];
        maxClock.text = data['maxclock'];
        wattage.text = data['wattage'];
        formFactor.text = data['formfactor'];
        country.text = data['country'];
        weight.text = data['itemweight'];
        warranty.text = data['warranty'];
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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('motherboard')
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
                    .map((doc) => doc['maxclock'] as String)
                    .toSet()
                    .toList();

                final model = snapshot.data!.docs
                    .map((doc) => doc['model'] as String)
                    .toSet()
                    .toList();
                final socket = snapshot.data!.docs
                    .map((doc) => doc['processorsocket'] as String)
                    .toSet()
                    .toList();
                final ram = snapshot.data!.docs
                    .map((doc) => doc['ramType'] as String)
                    .toSet()
                    .toList();
                final manufactured = snapshot.data!.docs
                    .map((doc) => doc['manufacturer'] as String)
                    .toSet()
                    .toList();
                final ssd = snapshot.data!.docs
                    .map((doc) => doc['ssdtype'] as String)
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
                              AdminUi.admTextField(
                                  label: 'Unique ID', textcontroller: idNum),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select Category',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: categoryName,
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
                                  controller: itemName,
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
                                  controller: processorSocket,
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
                                  controller: ramType,
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
                                  textcontroller: ramSize),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'RAM Slots', textcontroller: ramSlots),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                  label: const Text('Select Storage Type',
                                      style: TextStyle(
                                          color: CustomColors.appTheme)),
                                  controller: ssdType,
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
                                  label: 'Old Price', textcontroller: oldPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'New Price', textcontroller: newPrice),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Product Dimensions',
                                  textcontroller: dimension),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'SSD Slots', textcontroller: ssdSlots),
                              const SizedBox(height: 10),
                              AdminUi.featuresTextfield(
                                  label: 'Ports', textcontroller: ports),
                              const SizedBox(height: 10),
                              AdminUi.featuresTextfield(
                                  label: 'Features', textcontroller: features),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Form Factor',
                                  textcontroller: formFactor),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Power Consumption (W)',
                                  textcontroller: wattage),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Country', textcontroller: country),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Item Weight', textcontroller: weight),
                              const SizedBox(height: 10),
                              AdminUi.admTextField(
                                  label: 'Warranty', textcontroller: warranty),
                            ],
                          )),
                      const SizedBox(height: 30),
                      AdminUiHelper.customButton(context, () {
                        if (_formkey.currentState!.validate()) {
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
