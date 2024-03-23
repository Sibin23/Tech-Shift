import 'package:flutter/material.dart';
import 'package:prosample_1/User/Profile/contact_page.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ContactButton extends StatefulWidget {
  const ContactButton({super.key});

  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const ScreenContact())),
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
                  Image.asset('assets/icons/contact_us.png',
                      width: MediaQuery.of(context).size.width * .1),
                  const SizedBox(width: 10),
                  Text('Contact Us', style: TextStyling.subtitle2),
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
