import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';

class ScreenContact extends StatelessWidget {
  const ScreenContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Contact Us',
          style: TextStyling.appTitle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Image(
                      image: AssetImage('assets/login/login_logo.png'),
                      width: 100,
                      height: 100),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Tech Shift',
                        style: TextStyling.titleText,
                      ),
                      Text(
                        'Tech store',
                        style: TextStyling.subtitle,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Questions,Comments? You tell us. We Listen.',
                  style: TextStyling.titleText2),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Text('[Our Contact]', style: TextStyling.titleText2),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Icon(
                        Icons.location_pin,
                        color: AppColors.appTheme,
                        size: 30,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .8,
                          height: MediaQuery.of(context).size.height * .23,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ernakulam Experience Center Address',
                                  style: TextStyling.titleText2),
                              const SizedBox(height: 10),
                              const Text(
                                  'Tech Shift Malalmel Nettoor, KRA -83, Kochi, Kerala, India, 682040.'),
                              const SizedBox(height: 10),
                              Text(
                                'Email: sibinsebastian2306@gmail.com',
                                style: TextStyling.subtitle2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
