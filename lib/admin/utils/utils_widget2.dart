import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/admin/utils/utils_colors.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';


class AdminUi {
  static const space = SizedBox(height: 10);
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

  // text field features
  static featuresTextfield({required String label,
    required TextEditingController textcontroller}){
return TextFormField(
      minLines: 1,
      maxLines: 10,
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
      BuildContext context,
      {required text1, required text2}) {
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
                Navigator.pop(context);
                voidCallback1();
              },
              child: Text(
                text1,
                style: GoogleFonts.poppins(color: CustomColors.appTheme),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                voidCallback2();
              },
              child: Text(text2,
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
