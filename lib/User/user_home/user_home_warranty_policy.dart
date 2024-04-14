import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class WarrantyPolicy extends StatelessWidget {
  const WarrantyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('Warranty policy', style: TextStyling.appTitle),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Text('1.', style: TextStyling.subtitle)),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Please note that the products displayed here are for demonstration only.',
                            style: TextStyling.subtitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                space,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            '2.',
                            style: TextStyling.subtitle,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                              'The warranty information displayed here is for informational purposes only and does not constitute a real warranty. This application is for demonstration purposes and does not offer actual product sales or warranties.',
                              style: TextStyling.subtitle),
                        ),
                      ),
                    ],
                  ),
                ),
                space,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Text('3.', style: TextStyling.subtitle)),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                              'Thanks for understanding! We encourage you to try out all the cool features this app has to offer.',
                              style: TextStyling.subtitle),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
