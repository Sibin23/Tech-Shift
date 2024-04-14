import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/functions/fuctions.dart';

class ConfigDetail extends StatefulWidget {
  final Map<String, dynamic> pc;
  final String totalAmt;
  const ConfigDetail({super.key, required this.pc, required this.totalAmt});

  @override
  State<ConfigDetail> createState() => _ConfigDetailState();
}

class _ConfigDetailState extends State<ConfigDetail> {
  String card = 'Select a Graphics Card';
  String fan = 'Select a Cooler';
  String notNeed = 'Not Needed';
  @override
  Widget build(BuildContext context) {
    final custom = widget.pc;
    if (custom[gpu] == card) {
      custom[gpu] = notNeed;
    }
    if (custom[cooler] == fan) {
      custom[cooler] = notNeed;
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text('Your PC Configurations', style: TextStyling.subtitle3),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            final time = DateTime.now().toString();
            final id =
                DateTime.now().toString().replaceAll(RegExp(r'[^\d]'), '');
            final customPc = Map<String, dynamic>.from(widget.pc);
            customPc[totalPrice] = widget.totalAmt;
            toCustomCart(customPc, time);
            addAmount(
                newPrice: widget.totalAmt,
                oldPrice: widget.totalAmt,
                idNum: id,
                time: time);
            userDetails(idNum: id, time: time);
            showSnackbarWithAnimation();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.appTheme,
              ),
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .07,
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyling.subtitleWhite,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Processor', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['processor'], price: custom['processorprice']),
              const SizedBox(height: 10),
              Text('Motherboard', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['motherboard'],
                  price: custom['motherboardprice']),
              const SizedBox(height: 10),
              Text('RAM (Memory)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['ram'], price: custom['ramprice']),
              const SizedBox(height: 10),
              Text('SSD (Storage)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['ssd'], price: custom['ssdprice']),
              const SizedBox(height: 10),
              Text('Graphics Card (GPU)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['gpu'], price: custom['gpuprice']),
              const SizedBox(height: 10),
              Text('Cabinet Case', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['cabinet'], price: custom['cabinetprice']),
              const SizedBox(height: 10),
              Text('CPU Coolers', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['cooler'], price: custom['coolerprice']),
              const SizedBox(height: 10),
              Text('Power Supply Unit (PSU)',
                  style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context,
                  name: custom['psu'], price: custom['psuprice']),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .065,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Total Amount',
                              style: TextStyling.subtitleapptheme),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₹ ${widget.totalAmt}'.replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},"),
                            style: TextStyling.subtitleWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      )),
    );
  }

  alertMsg(e) {
    UiHelper.userSnackbar(context, e.toString());
  }

  void showSnackbarWithAnimation() {
    final snackBar = SnackBar(
      animation: CurvedAnimation(
        parent:
            AnimationMax(kAlwaysCompleteAnimation, kAlwaysDismissedAnimation),
        curve: Curves.easeInOutCirc,
      ),
      content: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.grey)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Lottie.asset('assets/animations/cart.json',
                width: 100, height: 100),
            const SizedBox(width: 10),
            Text('Added To Cart',
                style: TextStyle(color: Colors.purple.shade800, fontSize: 16)),
          ],
        ),
      ),
      elevation: 5,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      duration: const Duration(seconds: 2),
    );

    final scaffold = ScaffoldMessenger.maybeOf(context);
    if (scaffold != null) {
      scaffold.showSnackBar(snackBar).closed.then((_) => navigate());
    }
  }

  Future<void> navigate() async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (ctx) => const HomeInfo()),
      (route) => false, // Clear all previous routes
    );
  }
}
