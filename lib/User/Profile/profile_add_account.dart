import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/User/user_home/user_home_privacy_policies.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_widget3.dart';
import 'package:prosample_1/admin/const/variables.dart';

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
  bool isTrue = false;
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
                  h30,
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          UiHelper.profileTextField(
                              controller: _nameController,
                              text: 'Full Name*',
                              keyboardType: TextInputType.text,
                              validate: 'Name is required'),
                          h10,
                          UiHelper.profileTextField(
                              controller: _phoneNumberController,
                              text: 'Phone Number*',
                              keyboardType: TextInputType.number,
                              validate: 'Contact details is required'),
                          h10,
                          UiHelper.profileTextField(
                              controller: _cityController,
                              text: 'City*',
                              validate: 'City Name is required'),
                          h10,
                          UiHelper.profileTextField(
                              controller: _stateController,
                              text: 'State*',
                              validate: 'State Name is required'),
                          h10,
                          UiHelper.profileTextField(
                              controller: _pincodeController,
                              text: "Pincode*",
                              keyboardType: TextInputType.number,
                              validate: 'Pincode is reqired'),
                          h10,
                          UiHelper.profileTextField(
                              controller: locality,
                              text: 'Locality*',
                              validate: 'Locality is required'),
                          h10,
                          UiHelper.profileTextField(
                              controller: _addressController,
                              text: 'House No., Building Name',
                              validate: 'Adress is required'),
                          h10,
                          UiHelper.profileTextField(
                              controller: _roadNameController,
                              text: 'Road Name, Area',
                              validate: 'This field is required'),
                          h20,
                          Row(
                          children: [
                            Checkbox(
                                value: isTrue,
                                onChanged: (newValue) {
                                  setState(() {
                                    isTrue = newValue!;
                                  });
                                }),
                            RichText(
                              text: TextSpan(
                                text: 'I Agree with ',
                                style: TextStyling.categoryText,
                                children: [
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(color: AppColors.appTheme),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const HomePrivacyPolicy())),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ],
                      )),
                  h30,
                  UiHelper.customButton(context, () async {
                    if (_formkey.currentState!.validate()) {
                      if(isTrue == true){
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
                      } else if(isTrue == false){
                        UiHelper.userSnackbar(context, "Please Agree Privacy Policy");
                      }
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
