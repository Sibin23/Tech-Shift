import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/home/inventory/add%20inventory/add_items_details.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

class ScreenInventoryButton extends StatelessWidget {
  const ScreenInventoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const ScreenItemDetails()));
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
              Image.asset('assets/icons/inventory.png',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  color: Colors.white),
              const SizedBox(width: 30),
              Text('Inventory', style: CustomText.subtitleWb)
            ],
          ),
        ),
      ),
    );
  }
}
