import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addAmount(
    {required String newPrice,
    required String oldPrice,
    required String idNum,
    required String time}) async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  final amountCollection = FirebaseFirestore.instance
      .collection('User')
      .doc(id)
      .collection('Amount');

  await amountCollection.doc(time).set({
    'oldprice': double.parse(oldPrice),
    'newprice': double.parse(newPrice),
    'uid': id,
    'time': time,
    'idnum': idNum,
  });
}

Future<void> deleteAmount({required String docId}) async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  final amountCollection = FirebaseFirestore.instance
      .collection('User')
      .doc(id)
      .collection('Amount');
  final querySnapshot = await amountCollection.doc(docId).get();
  if (querySnapshot.exists) {
    await querySnapshot.reference.delete();
  }
}

Future<void> userDetails({required String idNum, required String time}) async {
  final user = FirebaseAuth.instance.currentUser!.uid;

  if (idNum.isEmpty || time.isEmpty) {
    throw Exception('idNum and time cannot be empty');
  }

  final data = {'uid': user, 'cart': idNum, 'time': time};
  final collectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(user)
      .collection('CartDetails')
      .doc(time);

  await collectionRef.set(data, SetOptions(merge: true));
}

Future<void> deleteUserDetiails(String time) async {
  final user = FirebaseAuth.instance.currentUser!.uid;
  final collectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(user)
      .collection('CartDetails')
      .doc(time);

  await collectionRef.delete();
}

Future<void> manageUserDetails({
  required String idNum,
  required String time,
  bool delete = false,
}) async {
  final user = FirebaseAuth.instance.currentUser!.uid;

  if (idNum.isEmpty || time.isEmpty) {
    throw Exception('idNum and time cannot be empty');
  }

  final collectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(user)
      .collection('CartDetails');

  if (delete) {
    final querySnapshot = await collectionRef
        .where('time', isEqualTo: time)
        .where('uid', isEqualTo: user)
        .get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  } else {
    final data = {'uid': user, 'cart': idNum, 'time': time};
    await collectionRef.doc(time).set(data, SetOptions(merge: true));
  }
}

Future<void> addInventoryCart(
    Map<String, dynamic> cartItem, String time) async {
  final user = FirebaseAuth.instance.currentUser!;
  final userUid = user.uid;
  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('others').doc(time);
  await cartCollectionRef.set(cartItem);
}

Future<void> addToCart(Map<String, dynamic> cartItem, String time) async {
  final user = FirebaseAuth.instance.currentUser!;
  final userUid = user.uid;
  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('others').doc(time);
  await cartCollectionRef.set(cartItem);
}

Future<void> buyNow(Map<String, dynamic> item, String time) async {
  final user = FirebaseAuth.instance.currentUser!;
  final userUid = user.uid;
  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('BuyNow').doc(time);
  await cartCollectionRef.set(item);
}

Future<List<Map<String, dynamic>>> getCartItems() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('others');

  final querySnapshot = await cartCollectionRef.get();
  final cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
  return cartItems;
}

Future<List<Map<String, dynamic>>> getBuyNow() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('BuyNow');

  final querySnapshot = await cartCollectionRef.get();
  final cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
  return cartItems;
}

Future<List<Map<String, dynamic>>> getConfigure() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('Configuration');

  final querySnapshot = await cartCollectionRef.get();
  final cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
  return cartItems;
}

Future<void> clearFromBuyNow() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final cartCollectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(userUid)
      .collection('BuyNow');

  final querySnapshot = await cartCollectionRef.get();
  for (final doc in querySnapshot.docs) {
    await doc.reference.delete();
  }
}

// Future<void> clearFromCustomPc() async {
//   final userUid = FirebaseAuth.instance.currentUser!.uid;
//   final cartCollectionRef = FirebaseFirestore.instance
//       .collection('User')
//       .doc(userUid)
//       .collection('Configuration');

//   final querySnapshot = await cartCollectionRef.get();
//   for (final doc in querySnapshot.docs) {
//     await doc.reference.delete();
//   }
// }
Future<List<DocumentSnapshot>> clearFromCustomPc() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final cartCollectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(userUid)
      .collection('Configuration');

  final querySnapshot = await cartCollectionRef.get();

  final documents = querySnapshot.docs;

  for (final doc in documents) {
    await doc.reference.delete();
  }

  return documents;
}

Future<void> clearCart() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final cartCollectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(userUid)
      .collection('others');

  final querySnapshot = await cartCollectionRef.get();
  for (final doc in querySnapshot.docs) {
    await doc.reference.delete();
  }
}

Future<void> clearFromDetails() async {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final cartCollectionRef = FirebaseFirestore.instance
      .collection('User')
      .doc(userUid)
      .collection('CartDetails');

  final querySnapshot = await cartCollectionRef.get();
  for (final doc in querySnapshot.docs) {
    await doc.reference.delete();
  }
}

Future<void> toCustomCart(
  Map<String, dynamic> pc,
  String time,
) async {
  final user = FirebaseAuth.instance.currentUser!;
  final userUid = user.uid;
  final userDocRef = FirebaseFirestore.instance.collection('User').doc(userUid);
  final cartCollectionRef = userDocRef.collection('Configuration').doc(time);
  await cartCollectionRef.set(pc);
}
