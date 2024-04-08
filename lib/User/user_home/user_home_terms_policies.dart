import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Terms & Conditions', style: TextStyling.appTitle),
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
                        'All information displayed, transmitted or carried on Tech Shift is protected by copyright and other intellectual property laws.',
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
                      child: Text('2.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'This Application is  updated and maintained independently by Tech Shift,THE TECH STORE. The content is owned by Tech Shift You may not modify, publish, transmit, transfer, sell, reproduce, create derivative work from, distribute, repost, perform, display or in any way commercially exploit any of the content.',
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
                      child: Text('3.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Tech Shift, CARE reserves the right, in its sole discretion, to suspend or cancel the service at any time if a computer virus, bug, or other technical problem corrupts the security, or proper administration of the service.',
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
                      child: Text('4.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Tech Shift Values the privacy of information pertaining to its associates. But We reserves the right to use or disclose information about your individual visits to our website or any information that you may give us, such as your name, address, email address or telephone number, to our associated sources, which doesn’t threaten the client’s privacy in any manner.',
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
                      child: Text('5.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Tech Shift reserves the right to refuse service to anyone at any time.',
                        style: TextStyling.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
