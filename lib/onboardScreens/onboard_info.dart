
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
        title: 'PC BUILD',
        description: 'LETS CRAFT YOUR DREAM PC',
        image: 'assets/OnboardScreen/Animation - 1706676593477.json'),
    OnboardInfo(
        title: 'TECH SHIFT',
        description: 'HERE WE CAN CONFIGURE YOUR PC',
        image: 'assets/OnboardScreen/Animation - 1706677779345.json'),
    OnboardInfo(
        title: 'WE ARE HERE',
        description: 'TWO DAYS DELIVERY IN ALL OVER INDIA',
        image: 'assets/OnboardScreen/Animation - 1706679585914.json'),
  ];
}
