import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class AdminUi {
  static customNavBar() {
    return BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.red,
        selectedIconTheme: const IconThemeData(color: Colors.green),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_sharp), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Builds'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Details'),
        ]);
  }
  static customCard(IconData icon, context, String title){
  
   return SizedBox(
    width: MediaQuery.of(context).size.width* 0.5,
    height: MediaQuery.of(context).size.height*.23,
    child: Card(
      child: Column(
        children: [
          Icon(icon,size: 20),
          Text(title,style: CustomText.title,),
        ],
      ),
    ),
   );
  }
}
