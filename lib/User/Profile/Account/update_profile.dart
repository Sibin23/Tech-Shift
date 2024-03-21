import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/widget3.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              UiCustom2.profileImage(() {
                pickImage();
              }, imageurl: imageurl),
              const SizedBox(height: 10),
              Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        UiHelper.customTextField(
                            controller: _nameController,
                            labeltext: 'Full Name',
                            iconData: Icons.person,
                            validate: 'Name is reqired'),
                        const SizedBox(height: 10),
                        UiHelper.customTextField(
                            controller: _phoneNumberController,
                            labeltext: 'Phone Number',
                            iconData: Icons.phone,
                            keyboardType: TextInputType.number,
                            validate: 'Contact Number is required'),
                        const SizedBox(height: 10),
                        UiHelper.customTextField(
                            controller: _cityController,
                            labeltext: 'City',
                            iconData: Icons.location_city_rounded,
                            validate: 'City Name is reqired'),
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
                            validate: 'Pincode is required'),
                        const SizedBox(height: 10),
                        UiHelper.customTextField(
                            controller: _addressController,
                            labeltext: 'House No., Building Name',
                            iconData: Icons.home_rounded,
                            validate: 'Address is reqired'),
                        const SizedBox(height: 10),
                        UiHelper.customTextField(
                            controller: area,
                            labeltext: 'Road Name, Area',
                            iconData: Icons.location_on,
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

                    updatedUser();
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
      'street': area.text,
      'imageUrl': imageurl,
    };
    FirebaseFirestore.instance.collection('User').doc(id).update(userDetails);
  }

  void updateMessage() {
    UiHelper.userSnackbar(context, 'Updated successfully');
  }
}
