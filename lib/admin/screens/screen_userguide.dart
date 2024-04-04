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
          itemCount: guide.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
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
