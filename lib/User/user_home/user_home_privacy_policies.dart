import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/admin/const/variables.dart';

class HomePrivacyPolicy extends StatelessWidget {
  const HomePrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Privacy Policy', style: TextStyling.appTitle),
            const SizedBox(height: 20),
            // Text('Personal Information',style: TextStyling.subtitle3),
            // h20,
            // Text('When you create an account, we collect you name, email address, phone number, and other information you provide.',style: TextStyling.subtitle2,),
            // Text('When you C'),
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
                        'This application is intended for educational purposes only. It is not intended for commercial use or distribution to third parties.',
                        style: TextStyling.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h10,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('2.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'This application collects user data solely to display order details and functionalities relevant to your account. This data is protected and never shared with other users or third parties. It\'s used exclusively for internal purposes to ensure proper app functionality. We understand the importance of data privacy and take measures to safeguard your information.',
                        style: TextStyling.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h10,
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
                        'Cash on delivery (COD) is currently implemented for testing purposes only. It is not available for actual product purchases. We appreciate your understanding.',
                        style: TextStyling.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h10,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('4.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'The products you see here are for demonstration purposes only. They are not currently available for purchase, but we appreciate your interest.',
                        style: TextStyling.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h10,
          ],
        ),
      )),
    );
  }
}
