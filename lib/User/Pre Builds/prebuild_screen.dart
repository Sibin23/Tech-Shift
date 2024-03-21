import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Details/db/user_model.dart';
import 'package:prosample_1/User/Pre%20Builds/details.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class PreBuildInfo extends StatefulWidget {
  final Map<String, dynamic> prebuild;
  const PreBuildInfo({super.key, required this.prebuild});

  @override
  State<PreBuildInfo> createState() => _PreBuildInfoState();
}

class _PreBuildInfoState extends State<PreBuildInfo> {
  bool isFavorite = true;
  @override
  Widget build(BuildContext context) {
    String id = widget.prebuild['docid'];
    String name = widget.prebuild['name'];
    String imageUrl = widget.prebuild['image'];
    String idNum = widget.prebuild['idnum'];
    String categoryName = widget.prebuild['categoryid'];
    String cabinet = widget.prebuild['case'];
    String oldPrice = widget.prebuild['oldprice'];
    String newPrice = widget.prebuild['newprice'];
    String processor = widget.prebuild['processor'];
    String board = widget.prebuild['motherboard'];
    String ram = widget.prebuild['ram'];
    String ssd = widget.prebuild['ssd'];
    String expstorage = widget.prebuild['expstorage'];
    String gpu = widget.prebuild['gpu'];
    String features = widget.prebuild['features'];
    String cooler = widget.prebuild['cooler'];
    String psu = widget.prebuild['psu'];
    String warranty = widget.prebuild['warranty'];
    Map<String, dynamic> prebuild = {
      'image': imageUrl,
      'idnum': idNum,
      'categoryid': categoryName,
      'name': name,
      'oldprice': oldPrice,
      'newprice': newPrice,
      'processor': processor,
      'motherboard': board,
      'ram': ram,
      'ssd': ssd,
      'expstorage': expstorage,
      'gpu': gpu,
      'features': features,
      'cooler': cooler,
      'psu': psu,
      'case': cabinet,
      'warranty': warranty
    };
    
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.appTheme),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                      child: Text('Buy Now', style: TextStyling.buttonB))),
              GestureDetector(
                onTap: () {
                  addToCart();
                  showSnackbarWithAnimation();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.appTheme,
                        borderRadius: BorderRadius.circular(6)),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Center(
                        child:
                            Text('Add to Cart', style: TextStyling.buttonW))),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Center(
                          child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }))),
                  Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey,
                              spreadRadius: 2,
                              offset: Offset(2, 2))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.elliptical(40, 20),
                            left: Radius.elliptical(40, 20))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(children: [
                      Positioned(
                        top: 10,
                        right: 10,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                  if (isFavorite) {
                                    final data = UserModel(
                                        id: id,
                                        name: name,
                                        category: categoryName,
                                        oldPrice: oldPrice,
                                        newPrice: newPrice,
                                        imageUrl: imageUrl);
                                    _saveToHive(id, data);
                                  } else {
                                    _removeFromFavorites(id);
                                  }
                                });
                              },
                              child: isFavorite
                                  ? const Icon(Icons.favorite_border_outlined,
                                      size: 30, color: Colors.black)
                                  : const Icon(Icons.favorite,
                                      size: 30, color: Colors.red)),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyling.titleText,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    UiCustom.rating(),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text('₹', style: TextStyling.subtitle),
                                        const SizedBox(width: 3),
                                        Text(
                                            newPrice.replaceAllMapped(
                                                RegExp(
                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                (Match m) => "${m[1]},"),
                                            style: TextStyling.newPbig),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Row(children: [
                                      Text('₹', style: TextStyling.subtitle),
                                      const SizedBox(width: 3),
                                      Text(
                                          oldPrice.replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => "${m[1]},"),
                                          style: TextStyling.oldGreyinfo),
                                    ]),
                                  ],
                                ),
                                const Divider(thickness: 1),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.local_shipping,
                                                  color: AppColors.appTheme,
                                                  size: 30),
                                              const SizedBox(width: 5),
                                              Text(
                                                'All India Shiping',
                                                style: TextStyling.categoryText,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.payments_outlined,
                                                  color: AppColors.appTheme,
                                                  size: 25),
                                              const SizedBox(width: 5),
                                              Text(
                                                'Competitive Price',
                                                style: TextStyling.categoryText,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.check_circle,
                                                  color: AppColors.appTheme,
                                                  size: 30),
                                              const SizedBox(width: 5),
                                              Text(
                                                'Branded Products',
                                                style: TextStyling.categoryText,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .admin_panel_settings_rounded,
                                                  color: AppColors.appTheme,
                                                  size: 30),
                                              const SizedBox(width: 5),
                                              Text(
                                                'Secured Shoping',
                                                style: TextStyling.categoryText,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => PreBuildDetails(
                                                  prebuild: prebuild)));
                                    },
                                    child: const Text(
                                      'View More',
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .05),
                        ],
                      ),
                    ]),
                  ),
                ]))));
  }

  Future<void> addToCart() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userUid = user.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userUid);
      final cartCollectionRef = userDocRef.collection('PreBuildCart').doc();
      final cartItem = {
        'image': widget.prebuild['image'],
        'idnum': widget.prebuild['idnum'],
        'categoryid': widget.prebuild['categoryid'],
        'name': widget.prebuild['name'],
        'oldprice': widget.prebuild['oldprice'],
        'newprice': widget.prebuild['newprice'],
        'case': widget.prebuild['case'],
        'processor': widget.prebuild['processor'],
        'motherboard': widget.prebuild['motherboard'],
        'ram': widget.prebuild['ram'],
        'ssd': widget.prebuild['ssd'],
        'expstorage': widget.prebuild['expstorage'],
        'gpu': widget.prebuild['gpu'],
        'features': widget.prebuild['features'],
        'cooler': widget.prebuild['cooler'],
        'psu': widget.prebuild['psu'],
        'warranty': widget.prebuild['warranty'],
      };
      await cartCollectionRef.set(cartItem);
    } catch (error) {
      alert(error);
    }
  }

  alert(error) {
    UiHelper.customTextAlert(context, error.toString());
  }

  void showSnackbarWithAnimation() {
    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.grey,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Lottie.asset('assets/Animations/cart.json',
                width: 100, height: 100),
            const SizedBox(width: 10),
            Text('Added To Cart',
                style: TextStyle(color: Colors.purple.shade800, fontSize: 16)),
          ],
        ),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        textColor: AppColors.appTheme,
        label: 'Dismiss',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((_) => navigate());
  }

  Future<void> navigate() async {
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const HomeInfo()),
        (route) => false);
  }

  Future<void> _saveToHive(String id, UserModel favorite) async {
    try {
      final box = await Hive.openBox<UserModel>('userBox');

      await box.put(id, favorite); // Use ID as unique key

      setState(() {
        isFavorite = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added to Favorites'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e); // Handle errors appropriately
    }
  }

  Future<void> _removeFromFavorites(String id) async {
    try {
      final box = await Hive.openBox<UserModel>('userBox');
      await box.delete(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item Deleted'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        isFavorite = false;
      });
    } catch (e) {
      print(e); // Handle errors appropriately
    }
  }
}
