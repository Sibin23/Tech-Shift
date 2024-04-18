import 'package:flutter/material.dart';
import 'package:prosample_1/User/profile/profiel_custompc_order_button.dart';
import 'package:prosample_1/User/profile/profile_add_account.dart';
import 'package:prosample_1/User/profile/profile_logout_button.dart';
import 'package:prosample_1/User/profile/profile_order_history_button.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class AccountNoUser extends StatefulWidget {
  const AccountNoUser({super.key});

  @override
  State<AccountNoUser> createState() => _AccountNoUserState();
}

class _AccountNoUserState extends State<AccountNoUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .4,
          child: Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(.99),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .27,
                child: Image.asset(
                  'assets/ads/profilebg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                left: MediaQuery.of(context).size.width * .25,
                right: MediaQuery.of(context).size.width * .25,
                child: Container(
                  width: MediaQuery.of(context).size.width * 3,
                  height: MediaQuery.of(context).size.height * .231,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 2.0,
                      ),
                      BoxShadow(
                        color: const Color.fromARGB(255, 206, 184, 210)
                            .withOpacity(0.3),
                        spreadRadius: 2.0,
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child:
                      ClipOval(child: Image.asset('assets/icons/profile.png')),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add Profile', style: TextStyling.appTitle),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const AddUserScreen()));
                },
                icon: Image.asset('assets/icons/Edit_icon.png',
                    width: MediaQuery.of(context).size.width * .12,
                    color: Colors.black)),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(spreadRadius: 0.6, color: AppColors.appTheme)
                ]),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .07,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email', style: TextStyling.subtitle),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(spreadRadius: 0.6, color: AppColors.appTheme)
                ]),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .07,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Mobile No.', style: TextStyling.subtitle),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
        const OrdersHistoryButto(),
        const Divider(),
        const CustomPcButton(),
        const Divider(),
        const LogOut(),
        const Divider(),
      ],
    );
  }
}
