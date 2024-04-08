import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/home/inventory/Coolers/add_coolers.dart';
import 'package:prosample_1/admin/home/inventory/Coolers/update_cooler.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';
import 'package:prosample_1/admin/utils/utils_widget2.dart';
import 'package:prosample_1/admin/utils/utils_widgets2.dart';

class CoolerDetails extends StatefulWidget {
  const CoolerDetails({super.key});

  @override
  State<CoolerDetails> createState() => _CoolerDetailsState();
}

class _CoolerDetailsState extends State<CoolerDetails> {
  Future deleteData(itemId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('processor').doc(itemId);
    await docRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back,color: Colors.white)),
        centerTitle: true,
        title: Text('Cooler Details',style: CustomText.apptitle,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ScreenAddCoolers()));
            }, icon: Image.asset('assets/icons/add.png',width: 30,color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cooler')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, snapshot) {
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

                      String itemId = document.id;
                      String imageUrl = document['image'];
                      String categoryName = document['name'];

                      return AdminUiHelper.updatelist(context, () {
                        AdminUi.customAlert(text1: 'Edit', text2: 'Delete', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => EditCooler(
                                        itemId: itemId,
                                      )));
                        }, () {
                          deleteData(itemId);
                          AdminUiHelper.customSnackbar(
                              context, 'Item Deleted Successfully !');
                          Navigator.pop(context);
                        }, context);
                      }, imageUrl: imageUrl, categoryName: categoryName);
                    },
                  );
                }
                return const Center(
                    child: CircularProgressIndicator(
                        color: CustomColors.appTheme));
              })),
    );
  }
}
