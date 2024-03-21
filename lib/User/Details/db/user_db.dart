import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:prosample_1/User/Details/db/user_model.dart';

ValueNotifier<List<UserModel>> profile = ValueNotifier([]);

// Future<void> addUser(UserModel value) async {
//   final userDB = await Hive.openBox<UserModel>('userProfile');
//   await userDB.add(value);

//   final dataID = await userDB.add(value);
//   value.id = dataID;
//   profile.value.add(value);
//   profile.notifyListeners();
// }

// Future<void> getUser() async {
//   final userDB = await Hive.openBox<UserModel>('userProfile');
//   profile.value.addAll(userDB.values);
//   userDB.values.first.id;
//   profile.notifyListeners();
// }
Future<UserModel?> getUser() async {
  final userDB = await Hive.openBox<UserModel>('userProfile');
  try {
    // Assuming there's only one user in the box
      final userModel = userDB.values.first;
      return userModel;
    
  } catch (error) {
    print('Error fetching user: $error');
    return null;
  }
}

Future<void> updateUser(String id, UserModel updatedUser) async {
  final userDB = await Hive.openBox<UserModel>('userProfile');
  try {
    await userDB.put(id, updatedUser);
  } catch (error) {
    print('Error updating user profile: $error');
  } finally {
    await userDB.close();
  }
}

// Future<void> updateUser(UserModel updatedUser) async {
//   final userDB = await Hive.openBox<UserModel>('userProfile');
//   final id = updatedUser.id;
//   try {
//     await userDB.put(id, updatedUser);
//     getUser();
//     print(userDB.toString());
//   } catch (error) {
//     print('Error updating user profile: $error');
//   } finally {
//     await userDB.close();
//   }
// }
