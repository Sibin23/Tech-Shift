import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

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
              Text('[Social Media]', style: TextStyling.titleText2),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .09,
                      height: MediaQuery.of(context).size.height * .07,
                      child: const Image(
                          image: AssetImage(
                              'assets/Ads section/Whats_app_logo.png'))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .09,
                      height: MediaQuery.of(context).size.height * .07,
                      child: const Image(
                          image: AssetImage(
                              'assets/Ads section/Instagram_logo.png'))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .09,
                      height: MediaQuery.of(context).size.height * .07,
                      child: const Image(
                          image: AssetImage(
                              'assets/Ads section/facebook_logo.png'))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .09,
                      height: MediaQuery.of(context).size.height * .07,
                      child: const Image(
                          image: AssetImage(
                              'assets/Ads section/Twitter_logo.png'))),
                ],
              ),
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
                                  'Tech Shift Pvt.Ltd COCHIN: 1st floor Above Union Bank, Le Meridian Road, Maradu, Ernakulam'),
                              const SizedBox(height: 10),
                              const Text('Phone: 9847144234')
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
