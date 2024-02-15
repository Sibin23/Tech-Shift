import 'package:flutter/material.dart';
import 'package:prosample_1/User/db/db_functions.dart';
import 'package:prosample_1/User/db/user_model.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class SamapleScreen extends StatefulWidget {
  const SamapleScreen({super.key});

  @override
  State<SamapleScreen> createState() => _SamapleScreenState();
}

class _SamapleScreenState extends State<SamapleScreen> {
  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Splash/splash screen new.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: ClipOval(
                      child: Image.asset('assets/Ads section/image_add.png'),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(80, 30),
                          topRight: Radius.elliptical(80, 30))),
                  child: ValueListenableBuilder(
                    valueListenable: profile,
                    builder: (BuildContext ctx, List<UserModel> profile,
                        Widget? child) {
                      return ListView.builder(
                          itemCount: 1,
                          itemBuilder: ((context, index) {
                            final data = profile[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Name'),
                                          Text(data.name,
                                              style: TextStyling.subtitle3),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (data.id != null) {
                                                  deleteUser(data.id!);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.delete_forever_rounded,
                                                size: 30,
                                                color: AppColors.appTheme,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.edit_note_rounded,
                                                  size: 30,
                                                  color: AppColors.appTheme))
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Text('Phone No.'),
                                  Text(data.phNum,
                                      style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('City'),
                                  Text(data.city, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('State'),
                                  Text(data.state,
                                      style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('Pincode'),
                                  Text(data.pincode,
                                      style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('House No, Building Name..,'),
                                  Text(data.home, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('Road Name, Area..,'),
                                  Text(data.street,
                                      style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            );
                          }));
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
