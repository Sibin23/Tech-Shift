
import 'package:flutter/material.dart';

import 'package:prosample_1/User/db/db_functions.dart';
import 'package:prosample_1/User/db/user_model.dart';
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

  // final ImagePicker _picker = ImagePicker();
  // XFile? _pickedImage;
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
                // SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.4,
                //     height: MediaQuery.of(context).size.height * 0.2,
                //     child: GestureDetector(
                //       onTap: () async {
                //         final XFile? image = await _picker.pickImage(
                //             source: ImageSource.gallery);
                //         if (image != null) {
                //           setState(() {
                //             _pickedImage = image;
                //           });
                //         }
                //       },
                //       child: ClipOval(
                //         child: SizedBox(
                //           height: 10,
                //           width: MediaQuery.of(context).size.width * 0.2,
                //           child: _pickedImage != null
                //               ? Image.file(
                //                   File(_pickedImage!.path),
                //                   fit: BoxFit.cover,
                //                 )
                //               : Image.asset(
                //                   "assets/Ads section/image_add.png",
                //                   width: 10,
                //                   height: 20,
                //                 ),
                //         ),
                //       ),
                //     )),
                const SizedBox(height: 10),
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
                UiHelper.customButton(context, () {
                  if (_formkey.currentState!.validate()) {
                    _addUserProfile(
                      _nameController.text.trim(),
                      _phoneNumberController.text.trim(),
                      _cityController.text.trim(),
                      _stateController.text.trim(),
                      _pincodeController.text.trim(),
                      _addressController.text.trim(),
                      _roadNameController.text.trim(),
                    );
                    UiHelper.userSnackbar(
                        context, 'Profile Added Successfully');
                    Navigator.pop(context);
                  }
                }, text: 'Add Profile'),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_addUserProfile(
  name,
  phone,
  city,
  state,
  pincode,
  home,
  street,
) {
  final userProfile = UserModel(
      name: name,
      phNum: phone,
      city: city,
      state: state,
      pincode: pincode,
      home: home,
      street: street);

  addUser(userProfile);
}
