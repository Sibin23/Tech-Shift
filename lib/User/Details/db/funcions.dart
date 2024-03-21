// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:prosample_1/User/Details/db/user_model.dart';

// Future<void> saveToHive(
//     BuildContext context, String showId, UserModel addToFav) async {
//   try {
//     final box = await Hive.openBox<UserModel>('userBox');
//     await box.put(showId, addToFav);

//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Item add to Favorite'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   } catch (e) {
//     // ignore: use_build_context_synchronously

//     print(e);
//   }
// }
// Future<void> _removeFromFavorites(String showId) async {
//     final box = await Hive.openBox<UserModel>('userBox');
//     await box.delete(showId);
//     setState(() {
//       // Update the favorite events list after removing the item
//       _favoriteEventsFuture = _getFavoriteEvents();});
// }