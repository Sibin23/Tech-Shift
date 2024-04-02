import 'package:flutter/material.dart';

class UserGuide extends StatelessWidget {
  const UserGuide({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> guide = [
      'First Add Category before adding inventory',
      'After adding necessary fields carefully. Then Click on to the Inventory Section',
      'Add necessary fields',
      'In the inventory section Admin can add, edit , delete the inventory fields',
      'Inventory Added Succesfully'
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Guide'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: guide.length, // Use the length of the guide list
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(8.0), // Add some padding for aesthetics
                child: Stack(
                  children: [
                    Align(
                      // Align the numbering text to the left
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold), // Make numbering text bold
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.85, // Adjust width as needed
                          child: Text(
                            guide[index],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
