import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/login.dart';
import 'package:prosample_1/onboardScreens/onboard_info.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen1 extends StatefulWidget {
  const OnboardScreen1({super.key});

  @override
  State<OnboardScreen1> createState() => _OnboardScreen1State();
}

class _OnboardScreen1State extends State<OnboardScreen1> {
  final controller = OnboardItems();
  final pageController = PageController();
  bool isFirstPage = false;
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: isLastPage
            ? getStartButton()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const ScreenLogin()),
                            (route) => false);
                      },
                      child: const Text('Skip')),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                      activeDotColor: AppColors.appTheme,
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                      child: const Text('Next')),
                ],
              ),
      ),
      body: PageView.builder(
          onPageChanged: (index) {
            setState(() {
              isLastPage = controller.items.length - 1 == index;
            });
          },
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(controller.items[index].image,
                      width: 300, fit: BoxFit.cover),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(controller.items[index].title,
                      style: GoogleFonts.concertOne(
                          color: Colors.black, fontSize: 30)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(controller.items[index].description,
                      style: TextStyling.categoryText)
                ],
              ),
            );
          }),
    );
  }

  Widget getStartButton() {
    return UiHelper.customButton(context, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const ScreenLogin()));
    }, text: 'Get Started');
  }
}
