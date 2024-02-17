// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// import 'package:lottie/lottie.dart';
// import 'package:prosample_1/User/db/db_functions.dart'; // Assuming this contains User.model and potentially profile-related functions
// import 'package:prosample_1/User/user%20profile/add_account.dart';
// import 'package:prosample_1/User/user%20profile/profile_details.dart';

// import 'package:prosample_1/User/utils/colors.dart';
// import 'package:prosample_1/User/utils/commonfile.dart';
// import 'package:prosample_1/User/utils/text_decorations.dart';

// @HiveType(typeId: 1)
// class UserModel {
//   @HiveField(0)
//   int? id;
//   @HiveField(1)
//   final String name;
//   @HiveField(2)
//   final String phNum;
//   @HiveField(3)
//   final String city;
//   @HiveField(4)
//   final String state;
//   @HiveField(5)
//   final String pincode;
//   @HiveField(6)
//   final String home;
//   @HiveField(7)
//   final String street;
//   @HiveField(8)
//   String? imagePath;

//   UserModel({
//     this.id,
//     required this.name,
//     required this.phNum,
//     required this.city,
//     required this.state,
//     required this.pincode,
//     required this.home,
//     required this.street,
//     this.imagePath,
//   });
// }

// // Global ValueNotifier for managing user data
// ValueNotifier<List<UserModel>> profile = ValueNotifier([]);

// // Add user function with image handling
// Future<void> addUser(UserModel value) async {
//   final userBox = await Hive.box<UserModel>('userProfile');

//   try {
//     // Save image if provided
//     if (value.imagePath != null) {
//       await saveImage(value.imagePath!);
//     }

//     // Add user to Hive and update ID and profile
//     final dataID = await userBox.add(value);
//     value.id = dataID;
//     profile.value.add(value);
//     profile.notifyListeners();
//   } catch (error) {
//     // Handle errors gracefully
//     print(error);
//     // Consider showing an error message to the user
//   }
// }

// // Fetch data from Hive when app starts
// Future<void> getUser() async {
//   final userBox = await Hive.box<UserModel>('userProfile');
//   profile.value.clear();
//   profile.value.addAll(userBox.values);
//   profile.notifyListeners();
// }

// // Function to delete a user
// Future<void> deleteUser(int id) async {
//   final userBox = await Hive.box<UserModel>('userProfile');
//   userBox.delete(id);
//   getUser();
// }

// // Edit/update user profile
// Future<void> updateUserProfile(UserModel updatedUser) async {
//   final userBox = await Hive.box<UserModel>('userProfile');

//   try {
//     // Check if image was updated
//     if (updatedUser.imagePath != null && updatedUser.imagePath != userBox.get(updatedUser.id!).imagePath) {
//       // Save new image and update imagePath
//       await saveImage(updatedUser.imagePath!);
//       updatedUser.imagePath = await getSavedImagePath(updatedUser.imagePath

