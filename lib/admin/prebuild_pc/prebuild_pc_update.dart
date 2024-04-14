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

class EditPC extends StatefulWidget {
  final Map<String, dynamic> item;
  final String id;
  const EditPC({super.key, required this.id, required this.item});

  @override
  State<EditPC> createState() => _EditPCState();
}

class _EditPCState extends State<EditPC> {
  final _formkey = GlobalKey<FormState>();
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
  String? image;
  late String imageurl = '';
  bool? isNew;
  bool? isPopular;
  String? idnum;
  String? categoryname;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() async {});
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

  @override
  void initState() {
    super.initState();

    final data = widget.item;
    setState(() {
      image = imageurl;
    });
    idnum = data[uniqueId];
    categoryname = data[category];
    _productName.text = data[name];
    imageurl = data[itemImage];
    _oldPrice.text = data[oldPrice];
    _newPrice.text = data[newPrice];
    _processor.text = data[processor];
    _motherBoard.text = data[motherboard];
    _ram.text = data[ram];
    _cooler.text = data[cooler];
    _ssd.text = data[ssd];
    _expandableStorage.text = data[expStorage];
    _gpu.text = data[gpu];
    _specialFeatures.text = data[features];
    _psu.text = data[psu];
    _case.text = data[cabinet];
    _warranty.text = data[warranty];
    isNew = data[newArival] == true ? isNew = true : isNew = false;
    isPopular = data[popular] == true ? isPopular = true : isPopular = false;
  }

  Future<void> updateData() async {
    final item = {
      itemImage: imageurl,
      name: _productName.text,
      uniqueId: widget.id,
      category: preBuild,
      oldPrice: _oldPrice.text,
      newPrice: _newPrice.text,
    };
    if (isNew == true) {
      FirebaseFirestore.instance.collection(newArival).doc(widget.id).set(item);
    }
    if (isPopular == true) {
      FirebaseFirestore.instance.collection(popular).doc(widget.id).set(item);
    }
    if (isNew == false) {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection(newArival).doc(widget.id);
      await docRef.delete();
    }
    if (isPopular == false) {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection(popular).doc(widget.id);
      await docRef.delete();
    }
    FirebaseFirestore.instance.collection(preBuild).doc(widget.id).set({
      uniqueId: idnum,
      category: categoryname,
      itemImage: imageurl.toString(),
      name: _productName.text,
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
    });
    setState(() {
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
      isNew = false;
      isPopular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: const Text('Update Pre-Build\'s'),
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
                      AdminUi.admTextField(
                          label: 'Memory', textcontroller: _ram),
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
                      AdminUi.admTextField(
                          label: 'Case', textcontroller: _case),
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
                    updateData();
                    AdminUiHelper.customSnackbar(
                        context, 'Item Updated Successfully !');
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
