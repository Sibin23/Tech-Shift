import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/ram.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class MotherboardConfig extends StatefulWidget {
  final Map<String, dynamic> config;
  final String socket;
  const MotherboardConfig(
      {super.key, required this.socket, required this.config});

  @override
  State<MotherboardConfig> createState() => _MotherboardConfigState();
}

class _MotherboardConfigState extends State<MotherboardConfig> {
  String? selectedRam;
  String? selectedSsd;
  String? _selectedDocumentId;
  @override
  Widget build(BuildContext context) {
    final selectedSocket = widget.socket;
    return Scaffold(
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.pop(context);
      }, () {
        final updatedConfig = Map<String, dynamic>.from(widget.config);
        updatedConfig['motherboard'] = _selectedDocumentId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => RamConfig(
                    ramType: selectedRam.toString(),
                    ssdType: selectedSsd.toString(),
                    config: updatedConfig)));
      }, amt: 'amt'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('motherboard')
                .where('processorsocket',
                    isGreaterThanOrEqualTo: selectedSocket)
                .where('processorsocket',
                    isLessThanOrEqualTo: '$selectedSocket.9')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 220,
                      ),
                      itemBuilder: ((context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String imageUrl = document['image'];
                        String name = document['name'];
                        String price = document['newprice'];
                        String ramType = document['ramType'];
                        String ssdType = document['ssdtype'];

                        final bool isSelected =
                            document.id == _selectedDocumentId;
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: GestureDetector(
                              onTap: () => setState(() {
                                    _selectedDocumentId = document.id;
                                    selectedRam = ramType;
                                    selectedSsd = ssdType;
                                  }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(2, 2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      color: Colors.grey.withOpacity(0.3),
                                    )
                                  ],
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.orange,
                                          width: 2,
                                        )
                                      : null,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            color: Colors.grey)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Image.network(imageUrl,
                                              fit: BoxFit.cover),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(name,
                                                style: TextStyling.subtitle2)),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('₹'),
                                            const SizedBox(width: 2),
                                            Text(
                                                price.replaceAllMapped(
                                                    RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => "${m[1]},"),
                                                style: TextStyling.newP),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        );
                      })),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      )),
    );
  }
}
