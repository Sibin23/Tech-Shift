import 'package:flutter/material.dart';
import 'package:prosample_1/User/Profile/warranty_policy.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class WarrantyButton extends StatefulWidget {
  const WarrantyButton({super.key});

  @override
  State<WarrantyButton> createState() => _WarrantyButtonState();
}

class _WarrantyButtonState extends State<WarrantyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const WarrantyPolicy())),
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
                  Image.asset('assets/icons/warranty.png',
                      width: MediaQuery.of(context).size.width * .1),
                  const SizedBox(width: 10),
                  Text('Warranty Policy', style: TextStyling.subtitle2),
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
