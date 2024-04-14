import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/details/details_ssd.dart';
import 'package:prosample_1/User/configuration/configuration_gpu.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/admin/const/variables.dart';

class SsdConfig extends StatefulWidget {
  final String power;
  final String total;
  final Map<String, dynamic> pc;
  final String ssdType;
  const SsdConfig({
    super.key,
    required this.ssdType,
    required this.total,
    required this.power,
    required this.pc,
  });

  @override
  State<SsdConfig> createState() => _SsdConfigState();
}

class _SsdConfigState extends State<SsdConfig> {
  String? selectedDocumentId;
  String? selectedSsd;
  String? selectedPrice;
  String? selectedPower;
  @override
  Widget build(BuildContext context) {
    selectedPower ??= 0.toString();
    int totalPwr =
        int.parse(widget.power) + int.parse(selectedPower.toString()) + 30;
    String amt = widget.total;
    selectedPrice ??= 0.toString();
    int totalamt = int.parse(amt) + int.parse(selectedPrice.toString());
    selectedPrice ??= 0.toString();
    selectedSsd ??= 'Select a SSD (Storage)';
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc[ssd] = selectedSsd;
              pc['ssdprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ConfigDetail4(
                            pc: pc,
                            total: totalamt.toString(),
                          )));
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
                        '₹ $totalamt'.replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => "${m[1]},"),
                        style: TextStyling.subtitleapptheme)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.pop(context);
      }, () {
        if (selectedDocumentId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              content: Center(
                  child: Text(
                'Please select a SSD (Storage)',
                style: TextStyling.subtitleWhite,
              )),
              backgroundColor: const Color.fromARGB(255, 245, 62, 49),
            ),
          );
        } else {
          final updatedConfig = Map<String, dynamic>.from(widget.pc);
          updatedConfig[ssd] = selectedSsd;
          updatedConfig['ssdprice'] = selectedPrice;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => GpuConfig(
                        price: totalamt.toString(),
                        pc: updatedConfig,
                        power: totalPwr.toString(),
                        ssd: widget.ssdType,
                      )));
        }
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Solid State Drive (SSD)', style: TextStyling.titleText),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(ssd)
                        .where(genType, isGreaterThanOrEqualTo: widget.ssdType)
                        .where(genType,
                            isLessThanOrEqualTo: '${widget.ssdType}.9')
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
                                mainAxisExtent: 225,
                              ),
                              itemBuilder: ((context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];

                                bool isSelected =
                                    document.id == selectedDocumentId;
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedDocumentId = null;
                                            selectedPower = null;
                                            selectedSsd = null;
                                            selectedPrice = null;
                                          } else {
                                            selectedDocumentId = document.id;
                                            selectedSsd = document[name];
                                            selectedPrice = document[newPrice];
                                            selectedPower = document[wattage];
                                          }
                                          isSelected = !isSelected;
                                        });
                                      },
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
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            )
                                          ],
                                          border: isSelected
                                              ? Border.all(
                                                  color: AppColors.appTheme,
                                                  width: 2,
                                                )
                                              : null,
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
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
                                                      0.11,
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          document[itemImage],
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                              'assets/categories/ssd.png',
                                                              fit: BoxFit
                                                                  .cover)),
                                                ),
                                                const SizedBox(height: 10),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(document[name],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            maxLines: 1,
                                                            style: TextStyling
                                                                .subtitle2),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${document[storage]}, ',
                                                                style: TextStyling
                                                                    .categoryText),
                                                            const SizedBox(
                                                                width: 3),
                                                            Text(
                                                                document[
                                                                    genType],
                                                                style: TextStyling
                                                                    .categoryText)
                                                          ],
                                                        ),
                                                        Text(document[speed],
                                                            style: TextStyling
                                                                .categoryText),
                                                      ],
                                                    )),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    const Text('₹'),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                        document[newPrice]
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                (Match m) =>
                                                                    "${m[1]},"),
                                                        style:
                                                            TextStyling.newP),
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
              ),
            ],
          ),
        ),
      )),
    );
  }
}
