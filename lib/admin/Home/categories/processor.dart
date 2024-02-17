// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ListProcessor extends StatefulWidget {
  const ListProcessor({super.key});

  @override
  State<ListProcessor> createState() => _ListProcessorState();
}

class _ListProcessorState extends State<ListProcessor> {
  final _idController = TextEditingController();
  final _textController = TextEditingController();
  Future submitData() async {
    final data = {
      'categoryid': _idController.text..trim().toLowerCase(),
      'name': _textController.text,
    };
    FirebaseFirestore.instance.collection('processor').doc('categoryid').set(data);

    setState(() {
      _textController.clear();
      _idController.clear();
    });
  }
  Future deleteItem(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('processor')
          .doc(documentId)
          .delete();
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Item Deleted Successfully",
        ),
      );
    } catch (error) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $error')),
      );
    }
  }
  void addItem(){
    
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Enter Details'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _idController,
                    decoration: const InputDecoration(hintText: 'Product Name'),
                  ),
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(hintText: 'Product Series'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Process data from controllers (name, email)
                  submitData();
                },
                child: const Text('Submit'),
              ),
            ],
          );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        title: Text(
          'Processor',
          style: CustomText.apptitle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                addItem();
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('processor')
                      .orderBy('categoryid')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          // Access the document and the desired field
                          final document = snapshot.data!.docs[index];

                          
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(3.0, 3.0),
                                    )
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        document.id,
                                        style: CustomText.title3,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await deleteItem(document.id);
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: CustomColors.appTheme,
                                      )
                                    ],
                                  ),
                                )),
                          ); // Display the field value
                        },
                      );
                    } else {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
                    }
                  },
                ),
              ),
              Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 3,
              )
            ],
          ),
        ),
      ),
      floatingActionButton:
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
    );
  }
}
