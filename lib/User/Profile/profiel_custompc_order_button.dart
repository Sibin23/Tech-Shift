import 'package:flutter/material.dart';
import 'package:prosample_1/User/profile/profile_custompc_order_history.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class CustomPcButton extends StatefulWidget {
  const CustomPcButton({super.key});

  @override
  State<CustomPcButton> createState() => _CustomPcButtonState();
}

class _CustomPcButtonState extends State<CustomPcButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const CustonPcOrderHistory())),
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
                  Image.asset('assets/icons/pc_order.png',filterQuality: FilterQuality.high,
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width * .1),
                  const SizedBox(width: 10),
                  Text("Configurated PC's", style: TextStyling.subtitle2),
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
