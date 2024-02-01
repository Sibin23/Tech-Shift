import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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

  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: isLastPage? getStartButton(): Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () =>
                    pageController.jumpTo(controller.items.length - 1),
                child: const Text('Back')),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn),
              effect: const WormEffect(
                activeDotColor: Colors.purple,
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
        onPageChanged: (index) => setState(() =>isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(controller.items[index].image, width: 300),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(controller.items[index].title,
                      style: GoogleFonts.concertOne(
                          color: Colors.black, fontSize: 30)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.items[index].description,
                    style: GoogleFonts.abel(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget getStartButton() {
    return Container(
      decoration: const BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.all(Radius.circular(8))),
      width: MediaQuery.of(context).size.width* 0.9,
      height: 55,
      child: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1)=> const ScreenLogin()));
          },
          child: Text('Get Started',
              style: GoogleFonts.robotoMono(color: Colors.white,fontSize: 17))),
    );
  }
}
