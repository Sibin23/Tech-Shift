// ignore_for_file: void_checks

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

class ScreenMyAccount extends StatefulWidget {
  const ScreenMyAccount({super.key});

  @override
  State<ScreenMyAccount> createState() => _ScreenMyAccountState();
}

class _ScreenMyAccountState extends State<ScreenMyAccount> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _roadNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final ImagePicker _picker =
      ImagePicker(); // Create an instance of ImagePicker
  XFile? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _pickedImage = image;
                          });
                        }
                      },
                      child: ClipOval(
                        child: SizedBox(
                          height: 10,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: _pickedImage != null
                              ? Image.file(
                                  File(_pickedImage!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/Ads section/image_add.png",
                                  width: 10,
                                  height: 20,
                                ),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Form(
                    child: Column(
                  children: [
                    UiHelper.customTextField(
                        controller: _nameController,
                        text: 'Full Name',
                        iconData: Icons.person),
                    const SizedBox(height: 10),
                    UiHelper.customTextField(
                        controller: _phoneNumberController,
                        text: 'Phone Number',
                        iconData: Icons.phone),
                    const SizedBox(height: 10),
                    UiHelper.customTextField(
                        controller: _cityController,
                        text: 'City',
                        iconData: Icons.location_city_rounded),
                    const SizedBox(height: 10),
                    UiHelper.customTextField(
                        controller: _stateController,
                        text: 'State',
                        iconData: Icons.location_city),
                    const SizedBox(height: 10),
                    UiHelper.customTextField(
                        controller: _pincodeController,
                        text: "Pincode",
                        iconData: Icons.post_add_outlined),
                    const SizedBox(height: 10),
                    UiHelper.customTextField(
                        controller: _addressController,
                        text: 'House No., Building Name',
                        iconData: Icons.home_rounded),
                    const SizedBox(height: 10),
                    UiHelper.customTextField(
                        controller: _roadNameController,
                        text: 'Road Name, Area',
                        iconData: Icons.location_on),
                  ],
                )),
                const SizedBox(height: 10),
                const SizedBox(height: 30),
                SizedBox(
                    width: MediaQuery.of(context).size.width * double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.purple),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            return UiHelper.customAlertBox(context,
                                'Your data has been saved Successfully,');
                          }
                        },
                        child: Text('Save Address',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)))),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
