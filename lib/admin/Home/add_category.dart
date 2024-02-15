import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  final TextEditingController _textController = TextEditingController();
  final _idController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  late String imageurl = '';

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {});
    }
  }

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Advertisements/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return imageurl = downloadUrl;
  }

  Future submitData() async {
    final data = {
      'categoryid': _idController.text,
      'image': imageurl.toString(),
      'name': _textController.text,
    };
    FirebaseFirestore.instance
        .collection('admin')
        .doc(_idController.text)
        .set(data);

    setState(() {
      _textController.clear();
      _idController.clear();
      imageurl = '';
    });
  }
  // Update Category
  Future updateCategory(categoryId)async{
    final updateId = {
      'categoryid': categoryId['categoryid'],
      'image': categoryId['image'],
      'name': categoryId['name'],
      
    };
    setState(() {
     _textController.text = updateId['name'];
     imageurl = updateId['image'];
     _idController.text = updateId['categoryid'];
   });
   FirebaseFirestore.instance.collection('admin').doc();
   
   
  }
  // Delete Category
  Future deleteCategory(document)async{
FirebaseFirestore.instance.collection('admin').doc(document).delete();
 // Reference to the specific document (obtain it earlier)


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image and Text'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Expanded(
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: imageurl.isEmpty
                          ? const Center(child: Text('Pick an image'))
                          : Image.network(imageurl.toString(),
                              fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        AdminUi.admTextField(
                            label: 'Category Id',
                            textcontroller: _idController),
                        const SizedBox(height: 20.0),
                        AdminUi.admTextField(
                            label: 'Category Name',
                            textcontroller: _textController),
                        const SizedBox(height: 20.0),
                      ],
                    )),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      submitData();
                      AdminUi.customSnackBar(context);
                    }
                  },
                  child: const Text('Submit',style: TextStyle(color: CustomColors.appTheme)),
                ),
                const Divider(thickness: 1,),
                const SizedBox(height: 20.0),
                Text('You can Edit items here',style: CustomText.title3),
                const SizedBox(height: 20.0),
                Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.29,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('admin').orderBy('name')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              // ignore: unused_local_variable
                              String imageUrl = document['image'];
                              String categoryName = document['name'];
                              // String categoryid = document['categoryid'];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      AdminUi.customAlert(() {
                                        Navigator.pop(context);
                                        updateCategory(document[index]);
                                        
                                      }, () { 
                                        Navigator.pop(context);
                                        deleteCategory(document[index]);
                                      }, context);
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.height *
                                          0.15,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .25,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              child: Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                              )),
                                          const SizedBox(height: 15),
                                          Text(categoryName,style: CustomText.categoryTitleText,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.3,
//                                     height: MediaQuery.of(context).size.height * 0.1,
//                                     child: Column(
//                                       children: [
//                                         SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 .25,
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.1,
//                                             child: Image.network(
//                                               imageUrl,
//                                               fit: BoxFit.cover,
//                                             )),
//                                         const SizedBox(height: 15),
//                                         Text(categoryName),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );