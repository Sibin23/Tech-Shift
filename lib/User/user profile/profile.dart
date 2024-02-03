import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/user%20profile/contact_page.dart';
import 'package:prosample_1/User/user%20profile/my_account.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/login.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                
                children: [
                  const SizedBox(

                  ),
                  Text('Hi, sibin@gmail.com', style: TextStyling.titleText),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UiHelper.customButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const ScreenMyAccount()));
                      }, 'My Account', Icons.person_pin),
                      UiHelper.customButton(() {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (ctx)=> const ScreenContact()));
                      }, 'Contact Us', Icons.call),
                     
                    ],
                  ),
                  const SizedBox(height: 20),
                   const Divider(thickness: 2),

                   const SizedBox(height: 40),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('More Information',style: TextStyling.titleText),
                       GestureDetector(
                         child: SizedBox(
                           
                           width: MediaQuery.of(context).size.width * 0.93,
                           height: 60,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   const Icon(Icons.view_list_outlined,color: Colors.purple),
                                   Text('Tems and Policies',style: TextStyling.titleText2),
                                 ],
                               ),
                               const Icon(Icons.arrow_forward_ios,color: Colors.purple,)
                             ],
                           ),
                         ),
                       ),
                     ],
                   )
                ],
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(bottom: 30),
             child: SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  double.infinity,
                              height: 50,
                              
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      backgroundColor: Colors.purple),
                                  onPressed: () async{
                                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
                        (route) => false);
                                  },
                                  child: Text('Logout',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
           ), 
                                       
          ],
        ),
      )),
    );
  }
}
