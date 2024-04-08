import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_widget3.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final locality = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  final area = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File? updatedImage;
  File? selectedImage;
  late String imageurl = '';
  String? image;

  get home => null;
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
        FirebaseStorage.instance.ref().child('User/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return imageurl = downloadUrl;
  }

  @override
  void initState() {
    final id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          image = imageurl;
        });
        imageurl = data['imageUrl'];
        _nameController.text = data['name'];
        _phoneNumberController.text = data['phNum'];
        _addressController.text = data['home'];
        _cityController.text = data['city'];
        _stateController.text = data['state'];
        locality.text = data['locality'];
        _pincodeController.text = data['pincode'];
        area.text = data['street'];
      }
    });
    super.initState();
  }

  Future<File?> pickFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Update Profile'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
              space,
              Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        UiHelper.profileTextField(
                            text: 'Full Name*',
                            controller: _nameController,
                            validate: 'Name is required'),
                        space,
                        UiHelper.profileTextField(
                            controller: _phoneNumberController,
                            text: 'Phone Number',
                            keyboardType: TextInputType.number,
                            validate: 'Contact Number is required'),
                        space,
                        Row(
                          children: [
                            Flexible(
                                child: UiHelper.profileTextField(
                                    text: 'City',
                                    controller: _cityController,
                                    validate: 'City is required')),
                            const SizedBox(width: 10),
                            Flexible(
                                child: UiHelper.profileTextField(
                                    text: 'State',
                                    controller: _stateController,
                                    validate: 'State is required'))
                          ],
                        ),
                        space,
                        UiHelper.profileTextField(
                            controller: _pincodeController,
                            text: "Pincode",
                            keyboardType: TextInputType.number,
                            validate: 'Pincode is required'),
                        space,
                        UiHelper.profileTextField(
                            controller: _addressController,
                            text: 'House No., Building Name',
                            validate: 'Address is reqired'),
                        space,
                        UiHelper.profileTextField(
                            controller: locality,
                            text: 'Locality',
                            validate: 'Locality is required'),
                        space,
                        UiHelper.profileTextField(
                            controller: area,
                            text: 'Road Name, Area',
                            validate: 'This field is required')
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: UiHelper.buttonSml(context, () async {
                  if (_formkey.currentState!.validate()) {
                    Navigator.pop(context);

                    await updatedUser();
                  }
                }, text: 'Update Profile'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> updatedUser() async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    final userDetails = {
      'userid': id.toString(),
      'name': _nameController.text.trim(),
      'phNum': _phoneNumberController.text,
      'city': _cityController.text,
      'state': _stateController.text,
      'pincode': _pincodeController.text,
      'home': _addressController.text,
      'locality': locality.text,
      'street': area.text,
      'imageUrl': imageurl,
    };
    FirebaseFirestore.instance.collection('User').doc(id).update(userDetails);
  }

  void updateMessage() {
    UiHelper.userSnackbar(context, 'Updated successfully');
  }
}
