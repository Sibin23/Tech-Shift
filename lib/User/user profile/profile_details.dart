import 'package:flutter/material.dart';
import 'package:prosample_1/User/db/db_functions.dart';
import 'package:prosample_1/User/db/user_model.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

class ProfileDetais extends StatefulWidget {
  
 const ProfileDetais({super.key});

  @override
  State<ProfileDetais> createState() => _ProfileDetaisState();
}

class _ProfileDetaisState extends State<ProfileDetais> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _roadNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
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
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset(
                        'assets/Ads section/itachi.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Form(
                        key: _formkey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              UiHelper.customTextField(
                                  controller: _nameController,
                                  labeltext: 'Full Name',
                                  iconData: Icons.person),
                              const SizedBox(height: 10),
                              UiHelper.customTextField(
                                  controller: _phoneNumberController,
                                  labeltext: 'Phone Number',
                                  iconData: Icons.phone,
                                  keyboardType: TextInputType.number),
                              const SizedBox(height: 10),
                              UiHelper.customTextField(
                                  controller: _cityController,
                                  labeltext: 'City',
                                  iconData: Icons.location_city_rounded),
                              const SizedBox(height: 10),
                              UiHelper.customTextField(
                                  controller: _stateController,
                                  labeltext: 'State',
                                  iconData: Icons.location_city),
                              const SizedBox(height: 10),
                              UiHelper.customTextField(
                                  controller: _pincodeController,
                                  labeltext: "Pincode",
                                  iconData: Icons.post_add_outlined,
                                  keyboardType: TextInputType.number),
                              const SizedBox(height: 10),
                              UiHelper.customTextField(
                                  controller: _addressController,
                                  labeltext: 'House No., Building Name',
                                  iconData: Icons.home_rounded),
                              const SizedBox(height: 10),
                              UiHelper.customTextField(
                                  controller: _roadNameController,
                                  labeltext: 'Road Name, Area',
                                  iconData: Icons.location_on),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: UiHelper.customButton(context, () {
                        if (_formkey.currentState!.validate()) {}
                      }, text: 'Save Address'),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }),
      )),
    );
  }
}
