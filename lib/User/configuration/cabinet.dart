import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/configuration_cooler.dart';
import 'package:prosample_1/User/configuration/details/details_cabinet.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';

class CabinetConfig extends StatefulWidget {
  final Map<String, dynamic> pc;
  final String price;
  final String power;
  const CabinetConfig(
      {super.key, required this.pc, required this.power, required this.price});

  @override
  State<CabinetConfig> createState() => _CabinetConfigState();
}

class _CabinetConfigState extends State<CabinetConfig> {
  String? selectedcabinet;
  String? selectedPrice;
  String? selctedPower;
  String? selectedminSize;
  String? selectedMaxSize;
  String? selectedDocumentId;
  String? selectedImage;
  @override
  Widget build(BuildContext context) {
    selectedPrice ??= 0.toString();
    selectedcabinet ??= 'Select a Cabinet';
    int totalAmt =
        int.parse(widget.price) + int.parse(selectedPrice.toString());
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white, actions: [
        GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc['cabinet'] = selectedcabinet;
              pc['cabinetprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ConfigDetail6(
                          pc: pc, totalAmt: totalAmt.toString())));
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: AppColors.appTheme, spreadRadius: 2)
                    ]),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info, color: AppColors.appTheme),
                          const SizedBox(width: 5),
                          Text(
                              '₹ $totalAmt'.replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => "${m[1]},"),
                              style: TextStyling.subtitleapptheme)
                        ]))))
      ]),
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.pop(context);
      }, () {
        if (selectedDocumentId == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 3),
              content: Text(
                'Please select a Cabinet',
                style: TextStyling.subtitleWhite,
              ),
              backgroundColor: const Color.fromARGB(255, 245, 62, 49)));
        } else {
          final pc = Map<String, dynamic>.from(widget.pc);
          pc['cabinet'] = selectedcabinet;
          pc['cabinetprice'] = selectedPrice;
          pc['image'] = selectedImage;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => CoolerConfig(
                      pc: pc,
                      power: widget.power,
                      price: totalAmt.toString())));
        }
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gaming Cabinets', style: TextStyling.titleText),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('cabinet')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 240,
                              ),
                              itemBuilder: ((context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];

                                bool isSelected =
                                    document.id == selectedDocumentId;
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),
                                    child: GestureDetector(
                                        onTap: () => setState(() {
                                              if (isSelected) {
                                                selectedDocumentId = null;
                                                selectedcabinet = null;
                                                selectedPrice = null;
                                                selectedminSize = null;
                                                selectedMaxSize = null;
                                              } else {
                                                selectedDocumentId =
                                                    document.id;
                                                selectedPrice =
                                                    document['newprice'];
                                                selectedcabinet =
                                                    document['name'];
                                                selectedMaxSize =
                                                    document['topcoolermax'];
                                                selectedminSize =
                                                    document['topcoolermin'];
                                                selectedImage =
                                                    document['image'];
                                              }
                                              isSelected = !isSelected;
                                            }),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:
                                                          const Offset(2, 2),
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      color: Colors.grey
                                                          .withOpacity(0.3))
                                                ],
                                                border: isSelected
                                                    ? Border.all(
                                                        color:
                                                            AppColors.appTheme,
                                                        width: 2,
                                                      )
                                                    : null),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          color: Colors.grey)
                                                    ]),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
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
                                                                    child:CachedNetworkImage(
                                                      imageUrl: document['image'],
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                              'assets/Categories/cabinet.png',
                                                              fit: BoxFit
                                                                  .cover)),)
                                                              ]),
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Text(
                                                                  document[
                                                                      'name'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  style: TextStyling
                                                                      .subtitle2)),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 3),
                                                              Text(
                                                                  document[
                                                                      'fansize'],
                                                                  style: TextStyling
                                                                      .categoryText)
                                                            ],
                                                          ),
                                                          Text(
                                                              document[
                                                                  'fancount'],
                                                              style: TextStyling
                                                                  .categoryText),
                                                          const SizedBox(
                                                              height: 8),
                                                          Row(children: [
                                                            const Text('₹'),
                                                            const SizedBox(
                                                                width: 2),
                                                            Text(
                                                                document[
                                                                        'newprice']
                                                                    .replaceAllMapped(
                                                                        RegExp(
                                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                        (Match m) =>
                                                                            "${m[1]},"),
                                                                style:
                                                                    TextStyling
                                                                        .newP)
                                                          ])
                                                        ]))))));
                              })),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
