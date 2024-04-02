import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatefulWidget {
  final double discount;
  const OrderSuccessScreen({super.key, required this.discount});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen>
    with TickerProviderStateMixin {
  void showAnimatedSnackbar(BuildContext context) {
    final animationController = AnimationController(
      vsync: Scaffold.of(context),
      duration: const Duration(milliseconds: 650),
    );

    final animation = Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.decelerate));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(0.0),
        margin: const EdgeInsets.all(0),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
         shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0), // Customize the border radius
  ), 
        content: SlideTransition(
          position: animation,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 8,
              child: Container(
                decoration: BoxDecoration(
                   color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                // height: 70,
                // width: 200,
               
                child: const Center(child: Text('This is an animated Snackbar!'))),
            ),
          ),
        ),
      ),
    );

    animationController.forward();
  }

  void callShowSnackbar(BuildContext context) {
    showAnimatedSnackbar(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              showAnimatedSnackbar(context);
            },
            child: Text('Show Animated Snackbar'),
          ),
          ElevatedButton(
            onPressed: () {
              callShowSnackbar(context);
            },
            child: Text('Call from Another Function'),
          ),
        ],
      ),
    );
  }
}
