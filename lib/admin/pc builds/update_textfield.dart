import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class EditPC extends StatefulWidget {
  final String itemId;
  const EditPC({super.key, required this.itemId});

  @override
  State<EditPC> createState() => _EditPCState();
}

class _EditPCState extends State<EditPC> {
  final _formkey = GlobalKey<FormState>();
  final _productCategory = TextEditingController();
  final _productName = TextEditingController();
  final _oldPrice = TextEditingController();
  final _newPrice = TextEditingController();
  final _processor = TextEditingController();
  final _motherBoard = TextEditingController();
  final _ram = TextEditingController();
  final _ssd = TextEditingController();
  final _expandableStorage = TextEditingController();
  final _gpu = TextEditingController();
  final _idNum = TextEditingController();
  final _specialFeatures = TextEditingController();
  final _psu = TextEditingController();
  final _case = TextEditingController();
  final _warranty = TextEditingController();
  String? image;
  late String imageurl = '';

  Future<void> pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
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

    FirebaseFirestore.instance
        .collection('prebuild')
        .doc(widget.itemId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        print(widget.itemId);
        Map<String, dynamic> data = snapshot.data()!;

        _productCategory.text = data['category'];
        _productName.text = data['name'];
        _idNum.text = data['idnum'];
        imageurl = data['image'];
        _oldPrice.text = data['oldprice'];
        _newPrice.text = data['newprice'];
        _processor.text = data['processor'];
        _motherBoard.text = data['motherboard'];
        _ram.text = data['ram'];
        _ssd.text = data['ssd'];
        _expandableStorage.text = data['expstorage'];
        _gpu.text = data['gpu'];
        _specialFeatures.text = data['features'];
        _psu.text = data['psu'];
        _case.text = data['case'];
        _warranty.text = data['warranty'];
      }
    });
  }

  updateData() {
    FirebaseFirestore.instance
        .collection('prebuild')
        .doc(widget.itemId) // Use the itemId
        .update({
      'categoryid': _productCategory.text.toLowerCase(),
      'image': imageurl,
      'idnum': _idNum.text,
      'name': _productName.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'processor': _processor.text,
      'motherboard': _motherBoard.text,
      'ram': _ram.text,
      'ssd': _ssd.text,
      'expstorage': _expandableStorage.text,
      'gpu': _gpu.text,
      'features': _specialFeatures.text,
      'psu': _psu.text,
      'case': _case.text,
      'warranty': _warranty.text,
    });
    setState(() {
      _productCategory.clear();
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

      _specialFeatures.clear();
      _psu.clear();
      _case.clear();
      _warranty.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      AdminUi.admTextField(label: 'Unique ID', textcontroller: _idNum),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Category Name',
                          textcontroller: _productCategory),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Product Name', textcontroller: _productName),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Old Price', textcontroller: _oldPrice),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'New Price', textcontroller: _newPrice),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Processor', textcontroller: _processor),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Motherboard', textcontroller: _motherBoard),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Memory', textcontroller: _ram),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Storage', textcontroller: _ssd),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Expandable Storage',
                          textcontroller: _expandableStorage),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(label: 'GPU', textcontroller: _gpu),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Features', textcontroller: _specialFeatures),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'PSU Certification', textcontroller: _psu),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Case', textcontroller: _case),
                      const SizedBox(height: 10),
                      AdminUi.admTextField(
                          label: 'Warranty', textcontroller: _warranty),
                      const SizedBox(height: 30),
                     
                    ])),
                AdminUiHelper.customButton(context, () {
                  if (_formkey.currentState!.validate()) {
                    updateData();

                    AdminUiHelper.customSnackbar(
                        context, 'Item Updated Successfully !');
                    Navigator.pop(context);
                  }
                }, text: 'Save'),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
