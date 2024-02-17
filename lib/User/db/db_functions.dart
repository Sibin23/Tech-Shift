import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:prosample_1/User/db/user_model.dart';

ValueNotifier<List<UserModel>> profile = ValueNotifier([]);

Future<void> addUser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('userProfile');
  await userDB.add(value);

  final dataID = await userDB.add(value);
  value.id = dataID;
  profile.value.add(value);
  print(value);
  profile.notifyListeners();
}

Future<void> getUser() async {
  final userDB = await Hive.openBox<UserModel>('userProfile');
  profile.value.clear();
  profile.value.addAll(userDB.values);
  profile.notifyListeners();
}

Future<void> deleteUser(int id) async {
  final userDB = await Hive.openBox<UserModel>('userProfile');
  userDB.delete(id);
  getUser();
}

Future<void> updateUser(UserModel id ,UserModel updatedUser) async {
  
    final userDB = await Hive.box<UserModel>('userProfile');
     await userDB.put(id ,updatedUser);
     profile.value.add(updatedUser);
    // final dataID = await userDB.values.;
  
    

   
    profile.notifyListeners();
    
 
}