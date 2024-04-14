import 'package:flutter/material.dart';
import 'package:prosample_1/admin/screens/screens_orders_history_button.dart';
import 'package:prosample_1/admin/screens/screens_build_button.dart';
import 'package:prosample_1/admin/screens/screens_custompc_order_button.dart';
import 'package:prosample_1/admin/screens/screens_intro.dart';
import 'package:prosample_1/admin/screens/screens_inventory_button.dart';
import 'package:prosample_1/admin/screens/screens_newarivals_buttom.dart';
import 'package:prosample_1/admin/screens/screens_popular_button.dart';
import 'package:prosample_1/admin/screens/screens_signout_button.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> sections = [
      const ScreenIntro(),
      const ScreenInventoryButton(),
      const ScreensBuildButton(),
      const ScreenPopularButton(),
      const ScreensNewarivalButton(),
      const ScreenOrderHistoryButton(),
      const ScreenCustomPcButton()
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: const [SignoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: sections[index],
              );
            }),
      ),
    );
  }
}
