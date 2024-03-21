import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/category/cabinet/info.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class CabinetDetailScreen extends StatefulWidget {
  const CabinetDetailScreen({super.key});

  @override
  State<CabinetDetailScreen> createState() => _CabinetDetailScreenState();
}

class _CabinetDetailScreenState extends State<CabinetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> const HomeInfo()), (route) => false);
        },icon: const Icon(Icons.arrow_back),),
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cabinet')
                .orderBy('name')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 230,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];

                        final cabinet = {
                          'image': document['image'],
                          'name': document['name'],
                          'idnum': document['idnum'],
                          'category': document['category'],
                          'manufacturer': document['manufacturer'],
                          'oldprice': document['oldprice'],
                          'newprice': document['newprice'],
                          'topcoolermin': document['topcoolermin'],
                          'topcoolermax': document['topcoolermax'],
                          'model': document['model'],
                          'productdimension': document['productdimension'],
                          'material': document['material'],
                          'country': document['country'],
                          'itemweight': document['itemweight'],
                          'usb2': document['usb2'],
                          'usb3': document['usb3'],
                          'warranty': document['warranty'],
                          'fansize': document['fansize'],
                          'fancount': document['fancount'],
                        };

                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          CabinetInfo(cabinet: cabinet)));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(2.0, 2.0))
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.02,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            child: CachedNetworkImage(
                                              imageUrl: document['image'],
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                          Text(document['category'],
                                              style: TextStyling.categoryText),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .13,
                                            child: Row(
                                              children: [
                                                Text('4.0',
                                                    style: TextStyling.rating),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.appTheme,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(document['name'],
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 3),
                                          Row(children: [
                                            Row(children: [
                                              const Text(
                                                '₹',
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                  document['oldprice']
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              "${m[1]},"),
                                                  style:
                                                      TextStyling.lineThrough),
                                            ]),
                                            const SizedBox(width: 10),
                                            Row(
                                              children: [
                                                const Text(
                                                  '₹',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                    document['newprice']
                                                        .replaceAllMapped(
                                                            RegExp(
                                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                            (Match m) =>
                                                                "${m[1]},"),
                                                    style: TextStyling.newP),
                                              ],
                                            )
                                          ])
                                        ]))),
                          ),
                        );
                      }),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Lottie.asset(
                        'assets/Animations/Animation - 1708393071899.json')),
              );
            }),
      )),
    );
  }
}
