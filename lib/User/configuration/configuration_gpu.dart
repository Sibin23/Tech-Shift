import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/configuration_cabinet.dart';
import 'package:prosample_1/User/configuration/details/details_gpu.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/admin/const/variables.dart';

class GpuConfig extends StatefulWidget {
  final Map<String, dynamic> pc;
  final String price;
  final String power;
  final String ssd;
  const GpuConfig(
      {super.key,
      required this.ssd,
      required this.pc,
      required this.price,
      required this.power});

  @override
  State<GpuConfig> createState() => _GpuConfigState();
}

class _GpuConfigState extends State<GpuConfig> {
  String? selectedDocumentId;
  String? selectedgpu;
  String? selectedPower;
  String? selectedPrice;
  @override
  Widget build(BuildContext context) {
    selectedPower ??= 0.toString();
    selectedgpu ??= 'Select a Graphics Card';
    int totalPwr =
        int.parse(widget.power) + int.parse(selectedPower.toString());
    selectedPrice ??= 0.toString();
    int totalAmt =
        int.parse(widget.price) + int.parse(selectedPrice.toString());
    return Scaffold(
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.pop(context);
      }, () {
        final updatedConfig = Map<String, dynamic>.from(widget.pc);
        updatedConfig[gpu] = selectedgpu;
        updatedConfig['gpuprice'] = selectedPrice.toString();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => CabinetConfig(
                    pc: updatedConfig,
                    power: totalPwr.toString(),
                    price: totalAmt.toString())));
      }),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc[gpu] = selectedgpu;
              pc['gpuprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ConfigDetail5(
                            pc: pc,
                            total: totalAmt.toString(),
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
                        '₹ $totalAmt'.replaceAllMapped(
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Graphics Card (GPU)', style: TextStyling.titleText),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(gpu)
                        .where(support, isGreaterThanOrEqualTo: widget.ssd)
                        .where(support, isLessThanOrEqualTo: '${widget.ssd}.9')
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
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 250,
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
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedDocumentId = null;
                                            selectedPower = null;
                                            selectedPrice = null;
                                            selectedgpu = null;
                                          } else {
                                            selectedDocumentId = document.id;
                                            selectedgpu = document[name];
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.11,
                                                      child: CachedNetworkImage(
                                                          imageUrl: document[itemImage],
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Image.asset(
                                                                  'assets/categories/gpu.png',
                                                                  fit: BoxFit
                                                                      .cover)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Text(document[name],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        maxLines: 1,
                                                        style: TextStyling
                                                            .subtitle2)),
                                                const SizedBox(height: 4),
                                                Text(document[model],
                                                    style: TextStyling
                                                        .categoryText),
                                                Row(
                                                  children: [
                                                    Text('${document[ramSize]},',
                                                        style: TextStyling
                                                            .categoryText),
                                                    const SizedBox(width: 3),
                                                    Text(document[ramType],
                                                        style: TextStyling
                                                            .categoryText)
                                                  ],
                                                ),
                                                Text(document[speed],
                                                    style: TextStyling
                                                        .categoryText),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Text('₹'),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                        document[newPrice].replaceAllMapped(
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
