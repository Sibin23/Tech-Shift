import 'package:flutter/material.dart';
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
          style: TextStyling.titleText,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                      image: AssetImage('assets/login/login_logo.png'),
                      width: 100,
                      height: 100),
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
              const SizedBox(height: 10),
              Text('Questions,Comments? You tell us. We Listen.',
                  style: TextStyling.titleText2),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 30,
                      ),
                      Text('Ernakulam Experience Center Address',
                          style: TextStyling.titleText2),
                      const SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.84,
                    height: MediaQuery.of(context).size.height * 0.15,
                    
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                      'Tech Shift Pvt.Ltd COCHIN: 1st floor Above Union Bank, Le Meridian Road, Maradu, Ernakulam'),
                  SizedBox(height: 10),
                  Text('Phone: 9847144234')
                      ],
                    ),
                  )
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
