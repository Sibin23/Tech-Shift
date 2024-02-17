import 'package:flutter/material.dart';
import 'package:prosample_1/User/db/db_functions.dart';
import 'package:prosample_1/User/db/user_model.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

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
  final _roadNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
 
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: profile,
            builder:
                (BuildContext ctx, List<UserModel> profile, Widget? child) {
              final data = profile;
              final user = data.first;
              _nameController.text = user.name;
              _phoneNumberController.text = user.phNum;
              _cityController.text = user.city;
              _stateController.text = user.state;
              _pincodeController.text = user.pincode;
              _addressController.text = user.home;
              _roadNameController.text = user.street;
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    
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
                              UiHelper.customTextField(controller: _roadNameController, labeltext: 
                              'Road Name, Area', iconData: Icons.location_on, validate: 'This field is required')
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: UiHelper.customButton(context, () {
                        if (_formkey.currentState!.validate()) {
                          updateProfile(
                            user.id,
                            _nameController.text,
                            _phoneNumberController.text,
                            _cityController.text,
                            _stateController.text,
                            _pincodeController.text,
                            _addressController.text,
                            _roadNameController.text,
                          );
                          UiHelper.userSnackbar(
                              context, 'Updated successfully');
                          Navigator.pop(context);
                        }
                      }, text: 'Update Profile'),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }),
      )),
    );
  }

  void updateProfile(id,name, phNum, city, state, pincode, house, road) {
    final updatedUser = UserModel(
      id: id,
        name: name,
        phNum: phNum,
        city: city,
        state: state,
        pincode: pincode,
        home: house,
        street: road);
        updateUser(id, updatedUser);
  }
}
