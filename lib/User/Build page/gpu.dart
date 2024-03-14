import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/cabinet.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class GpuConfig extends StatefulWidget {
  final String power;
  final String ssd;
  final Map<String, dynamic> config;
  const GpuConfig(
      {super.key,
      required this.ssd,
      required this.power,
      required this.config});

  @override
  State<GpuConfig> createState() => _GpuConfigState();
}

class _GpuConfigState extends State<GpuConfig> {
  String? selectedDocumentId;
  String? selectedgpu;
  String? selectedPower;
  @override
  Widget build(BuildContext context) {
    final ssd = widget.ssd;
    selectedPower ??= 0.toString();
    int totalPwr = int.parse(widget.power) + int.parse(selectedPower.toString());
    print(totalPwr);
    return Scaffold(
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.pop(context);
      }, () {
        final updatedConfig = Map<String, dynamic>.from(widget.config);
        updatedConfig['gpu'] = selectedDocumentId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => CabinetConfig(config: updatedConfig)));
      }),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('gpu')
                .where('support', isGreaterThanOrEqualTo: ssd)
                .where('support', isLessThanOrEqualTo: '$ssd.9')
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
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: ((context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String imageUrl = document['image'];
                        String name = document['name'];
                        String model = document['model'];
                        String price = document['newprice'];
                        String ramType = document['ramtype'];
                        String size = document['ramsize'];
                        String speed = document['speed'];
                        String wattage = document['wattage'];
                        final bool isSelected =
                            document.id == selectedDocumentId;
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: GestureDetector(
                              onTap: () => setState(() {
                                    selectedDocumentId = isSelected
                                        ? 'It is Optional'
                                        : document.id;
                                    selectedgpu = name;
                                    selectedPower = wattage;
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              child: Image.network(imageUrl,
                                                  fit: BoxFit.cover),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(name,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                                style: TextStyling.subtitle2)),
                                        const SizedBox(height: 5),
                                        Text(model,
                                            style: TextStyling.categoryText),
                                        Row(
                                          children: [
                                            Text('$size,',
                                                style:
                                                    TextStyling.categoryText),
                                            const SizedBox(width: 3),
                                            Text(ramType,
                                                style: TextStyling.categoryText)
                                          ],
                                        ),
                                        Text(speed,
                                            style: TextStyling.categoryText),
                                        const SizedBox(height: 8),
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
