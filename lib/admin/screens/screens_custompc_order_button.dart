import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/screens/screens_custompc_order_history.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

class ScreenCustomPcButton extends StatelessWidget {
  const ScreenCustomPcButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const OrderConfiguration()));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
            image: const DecorationImage(
                image: AssetImage(
                  admBoxImg,
                ),
                fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset('assets/icons/pc_order.png',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  color: Colors.white),
              const SizedBox(width: 20),
              Text('Custom PC Orders', style: CustomText.subtitleWb)
            ],
          ),
        ),
      ),
    );
  }
}
