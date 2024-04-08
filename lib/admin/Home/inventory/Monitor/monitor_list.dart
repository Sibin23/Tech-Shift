import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/home/inventory/Monitor/add_monitor.dart';
import 'package:prosample_1/admin/home/inventory/Monitor/update_monitor.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class MonitorDetails extends StatefulWidget {
  const MonitorDetails({super.key});

  @override
  State<MonitorDetails> createState() => _MonitorDetailsState();
}

class _MonitorDetailsState extends State<MonitorDetails> {
   Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('monitor').doc(itemId);
    await docRef.delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text('Mouse Details', style: CustomText.apptitle),
        backgroundColor: CustomColors.appTheme,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const ScreenAddMonitor()));
                },
                icon: Image.asset('assets/icons/add.png',
                    width: 30, color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(child:  StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('monitor')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text('No Items Yet')),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      String imageUrl = document['image'];
                      String name = document['name'];
                      String itemId = document.id;

                      return AdminUiHelper.updatelist(context, () {
                        AdminUi.customAlert(text1: 'Edit', text2: 'Delete', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      UpdateMonitor(itemId: itemId)));
                        }, () {
                          deleteData(itemId);
                          AdminUiHelper.customSnackbar(
                              context, 'Item Deleted Successfully !');
                        }, context);
                      }, imageUrl: imageUrl, categoryName: name);
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: CustomColors.appTheme));
                }
              },
            )
      ),
    );
  }
}