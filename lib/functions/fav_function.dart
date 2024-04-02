import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addToFav(
    {required String image,
    required String name,
    required String category,
    required String time,
    required String idNum,
    required String oldPrice,
    required String newPrice}) async {
  final user = FirebaseAuth.instance.currentUser!.uid;
  final favRef = FirebaseFirestore.instance
      .collection('User')
      .doc(user)
      .collection('Favorites')
      .doc(time);
  final favData = {
    'uid': user,
    'time': time,
    'category': category,
    'image': image,
    'name': name,
    'idnum': idNum,
    'oldprice': oldPrice,
    'newprice': newPrice,
  };
  await favRef.set(favData);
}

Future<void> deleteFromFav({required String idNum}) async {
  final user = FirebaseAuth.instance.currentUser!.uid;
  final favRef = FirebaseFirestore.instance
      .collection('User')
      .doc(user)
      .collection('Favorites');

  final querySnapshot = await favRef
      .where('idnum', isEqualTo: idNum)
      .where('uid', isEqualTo: user)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}


