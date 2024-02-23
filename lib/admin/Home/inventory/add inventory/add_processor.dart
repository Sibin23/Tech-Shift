import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/Detail%20screen/dropdown_details.dart';
import 'package:prosample_1/admin/utils/common2.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenAddProcessor extends StatefulWidget {
  
  const ScreenAddProcessor({super.key,
 
  });

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
  final _series = TextEditingController();
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
      
      'image': imageurl.toString(),
      'name': _productName.text,
      'oldprice': _oldPrice.text,
      'newprice': _newPrice.text,
      'series': _series.text,
      'cores': _cores.text,
      'threads': _threads.text,
      'socket': _socket.text,
      'speed': _speed.text,
      'cache': _cache.text,
      'graphics': _integratedGraphics.text,
      'cooler': _includedCPUCooler.text,
      'tdp': _tdp.text,
    };
    FirebaseFirestore.instance
        .collection('processor')
        .doc(_productName.text.toLowerCase())
        .set(data);

    setState(() {
      _productCategory.clear();
      _productName.clear();
      _oldPrice.clear();
      _newPrice.clear();
      _series.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                  }, imageurl: imageurl),
                  const SizedBox(height: 20),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          DropDownScreen(
                            onProcessorSelected: _handleProcessorSelected,
                            onSocketSelected: _handleSocketSelected,
                            onCoresSelected: _handleCoresSelected,
                            onThreadsSelected: _handleThreadsSelected,
                            onSpeedSelected: _handleSpeedSelected,
                          ),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'Old Price', textcontroller: _oldPrice),
                          const SizedBox(height: 10),
                          AdminUi.admTextField(
                              label: 'New Price', textcontroller: _newPrice),
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
                  const SizedBox(height: 30),
                  AdminUiHelper.customButton(context, () {
                    if (_formkey.currentState!.validate() &&
                        _socket.text.isNotEmpty &&
                        _cores.text.isNotEmpty &&
                        _threads.text.isNotEmpty &&
                        _speed.text.isNotEmpty) {
                      submitData();
                      AdminUiHelper.customSnackbar(
                          context, 'Item Added Successfully !');
                    }
                  }, text: 'Save'),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSocketSelected(String value) {
    _socket.text = value;
  }

  void _handleCoresSelected(String value) {
    // Store selected socket value
    _cores.text = value;
  }

  void _handleThreadsSelected(String value) {
    // Store selected socket value
    _threads.text = value;
  }

  void _handleSpeedSelected(String value) {
    // Store selected socket value
    _speed.text = value;
  }
  void _handleProcessorSelected(String value){
    _productName.text;
  }
}
