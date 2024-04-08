import 'package:flutter/material.dart';
import 'package:prosample_1/User/profile/profile_order_history.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class OrdersHistoryButto extends StatefulWidget {
  const OrdersHistoryButto({super.key});

  @override
  State<OrdersHistoryButto> createState() => _OrdersHistoryButtonState();
}

class _OrdersHistoryButtonState extends State<OrdersHistoryButto> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const ProfileOrderHistory())),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .05,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/order_history.png',filterQuality: FilterQuality.high,
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width * .1),
                  const SizedBox(width: 10),
                  Text("Order's History", style: TextStyling.subtitle2),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.appTheme)
            ],
          ),
        ),
      ),
    );
  }
}
