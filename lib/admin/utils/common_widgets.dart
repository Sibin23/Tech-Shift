import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/admin/utils/colors.dart';
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

  static customCard(IconData icon, context, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * .20,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, size: 50),
              Text(
                title,
                style: CustomText.title,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Custom TextField

  static admTextField({
    required String label,
    required TextEditingController textcontroller,
  }) {
    return TextFormField(
      controller: textcontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Data is required';
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(color: CustomColors.appTheme),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: CustomColors.appTheme)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Custom Snackbar
  static customSnackBar(context) {
    SnackBar(
        content: const Text("Data has been saven successfully"),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5));

//     return Scaffold.of(context).showSnackBar(
//      SnackBar(content: Text("Thanks for using snackbar",
//      textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
//      FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,)
// );
  }

  static customCategoryCard(BuildContext context,
      {required String imageUrl, required String categoryName}) {
    Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(categoryName),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Alert Dialogue
  static customAlert(VoidCallback voidCallback1, VoidCallback voidCallback2,
      BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                
                voidCallback1();
              },
              child: Text(
                'Edit',
                style: GoogleFonts.poppins(color: CustomColors.appTheme),
              ),
            ),
            TextButton(
              onPressed: () {
                
                voidCallback2();
              },
              child: Text('Delete',
                  style: GoogleFonts.poppins(color: CustomColors.appTheme)),
            ),
          ],
        );
      },
    );
  }

  // Custom ElevatedButton
  static customButton(
    BuildContext context, {
    required GlobalKey formkey,
    required VoidCallback voidCallback,
    required String text,
  }) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.appTheme,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
        ),
        onPressed: () {
          voidCallback();
        },
        child: Text(
          text,
          style: CustomText.apptitle,
        ));
  }
  
}
