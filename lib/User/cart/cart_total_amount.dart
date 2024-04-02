import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class TotalAmout extends StatefulWidget {
  const TotalAmout({super.key});

  @override
  State<TotalAmout> createState() => _TotalAmoutState();
}

class _TotalAmoutState extends State<TotalAmout> {
  Stream<double> totalNewPriceStream() async* {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final amountCollection = FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .collection('Amount');

    yield 0.0;

    await for (var querySnapshot in amountCollection.snapshots()) {
      double total = 0.0;
      for (var doc in querySnapshot.docs) {
        final payment = doc.data();
        if (payment.containsKey('newprice')) {
          total += payment['newprice'] as double;
        }
      }
      yield total;
    }
  }

  Stream<double> totalOldPriceStream() async* {
    final id = FirebaseAuth.instance.currentUser!.uid;
    final amountCollection = FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .collection('Amount');

    yield 0.0;

    await for (var querySnapshot in amountCollection.snapshots()) {
      double total = 0.0;
      for (var doc in querySnapshot.docs) {
        final payment = doc.data();
        if (payment.containsKey('oldprice')) {
          // Check for oldprice key
          total += payment['oldprice'] as double;
        }
      }
      yield total;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: totalNewPriceStream(),
      builder: (context, newPriceSnapshot) {
        return StreamBuilder<double>(
          stream: totalOldPriceStream(),
          builder: (context, oldPriceSnapshot) {
            if (newPriceSnapshot.hasError || oldPriceSnapshot.hasError) {
              return Text(
                  'Error: ${newPriceSnapshot.error ?? oldPriceSnapshot.error}');
            }

            switch (newPriceSnapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                final newPrice = newPriceSnapshot.data ?? 0.0;
                final oldPrice = oldPriceSnapshot.data ?? 0.0;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height *
                      0.2, // Adjust height as needed

                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amout:', style: TextStyling.details),
                            Text(
                              '₹${oldPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Offer Price:', style: TextStyling.details),
                            Text(
                              '₹ ${newPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Discount: ',
                                style: TextStyling.details),
                            Text(
                              '₹${(newPrice - oldPrice).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                );
              default:
                return const Text('Error');
            }
          },
        );
      },
    );
  }
}
