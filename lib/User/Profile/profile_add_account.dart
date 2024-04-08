import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_widget3.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final locality = TextEditingController();
  final _addressController = TextEditingController();
  final _roadNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? id;
  late String imageurl = '';
  String? imageNew;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {
        imageNew = imageurl.toString();
      });
    }
  }

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('User/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  Future<void> getId() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    id = userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Profile'),
            surfaceTintColor: Colors.white),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .22,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UiCustom2.profileImage(() {
                              pickImage();
                            }, imageurl: imageurl),
                          ],
                        ),
                        Positioned(
                            bottom: 0,
                            right: MediaQuery.of(context).size.width * .28,
                            child: GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                    'assets/icons/Edit_icon.png',
                                    color: Colors.black,
                                    fit: BoxFit.cover,
                                  )),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          UiHelper.customTextField(
                              controller: _nameController,
                              labeltext: 'Full Name',
                              iconData: Icons.person,
                              validate: 'Name is required'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: _phoneNumberController,
                              labeltext: 'Phone Number',
                              iconData: Icons.phone,
                              keyboardType: TextInputType.number,
                              validate: 'Contact details is required'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: _cityController,
                              labeltext: 'City',
                              iconData: Icons.location_city_rounded,
                              validate: 'City Name is required'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: _stateController,
                              labeltext: 'State',
                              iconData: Icons.location_city,
                              validate: 'State Name is required'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: _pincodeController,
                              labeltext: "Pincode",
                              iconData: Icons.post_add_outlined,
                              keyboardType: TextInputType.number,
                              validate: 'Pincode is reqired'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: locality,
                              labeltext: 'Locality',
                              iconData: Icons.location_city,
                              validate: 'Locality is required'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: _addressController,
                              labeltext: 'House No., Building Name',
                              iconData: Icons.home_rounded,
                              validate: 'Adress is required'),
                          const SizedBox(height: 10),
                          UiHelper.customTextField(
                              controller: _roadNameController,
                              labeltext: 'Road Name, Area',
                              iconData: Icons.location_on,
                              validate: 'This field is required'),
                        ],
                      )),
                  const SizedBox(height: 30),
                  UiHelper.customButton(context, () async {
                    if (_formkey.currentState!.validate()) {
                      Navigator.pop(context);
                      final user = {
                        'userid': id.toString(),
                        'name': _nameController.text.trim(),
                        'phNum': _phoneNumberController.text.trim(),
                        'city': _cityController.text.trim(),
                        'state': _stateController.text.trim(),
                        'locality': locality.text.trim(),
                        'pincode': _pincodeController.text.trim(),
                        'home': _addressController.text.trim(),
                        'street': _roadNameController.text.trim(),
                        'imageUrl': imageurl,
                      };
                      addProfile(user);
                    }
                  }, text: 'Add Profile'),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ));
  }

  void navigate() {
    UiHelper.userSnackbar(context, 'Profile Added Successfully');
  }

  Future<void> addProfile(Map<String, String> user) async {
    FirebaseFirestore.instance.collection('User').doc(id).set(user);
  }
}
