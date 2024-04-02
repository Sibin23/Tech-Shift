class OnboardInfo {
  final String title;
  final String description;
  final String image;

  OnboardInfo(
      {required this.title, required this.description, required this.image});
}

class OnboardItems {
  List<OnboardInfo> items = [
    OnboardInfo(
        title: 'Lets Build Your PC',
        description:
            'Unleash Your Creativity And Build Your Own PC From The Scratch Starting From Processor, Motherboard, Graphics Card etc.',
        image: 'assets/OnboardScreen/Animation - 1706679585914.json'),
    OnboardInfo(
        title: 'TECH SHIFT',
        description:
            'By Experts For Expets. We Offer You The Expertise And Resources To Create Your Perfect PC',
        image: 'assets/OnboardScreen/Animation - 1706677779345.json'),
    OnboardInfo(
        title: 'Free Installation and Tech Support',
        description: 'Best in Class Brand Support and Uncompromised Quality',
        image: 'assets/OnboardScreen/Animation - 1706676593477.json'),
  ];
}
