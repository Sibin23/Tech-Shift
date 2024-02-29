import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/Home_screen/home_page.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/create_account.dart';
import 'package:prosample_1/User/forgot_password.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/admin/screens/admin_home.dart';
import 'package:prosample_1/admin/screens/home_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

const saveKeyName = 'adminLoggedOut';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _obscuretext = true;
  @override
  void dispose() {
    _obscuretext;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                      height: 100,
                      image: AssetImage('assets/login/login_logo.png')),
                  Text('Welcome Back,',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20)),
                  const SizedBox(height: 10),
                  Text('Discover Limitless Choices and Unmatched Convenience.',
                      style: GoogleFonts.poppins(color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                  key: _formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email address is required';
                              }
                              return null;
                            },
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email_rounded),
                                label:
                                    Text('Email', style: GoogleFonts.poppins()),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 20),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required.';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            obscureText: _obscuretext,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.password_rounded),
                                label: Text('Password',
                                    style: GoogleFonts.poppins()),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  child: Icon(
                                    _obscuretext
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ScreenPassword()));
                              },
                              child: Text('Forgot Password?',
                                  style: GoogleFonts.poppins(
                                      color: AppColors.appTheme)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        UiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            if (email == 'admin@gmail.com' &&
                                password == 'admin23') {
                              goToAdminHome();
                            } else {
                              signInWithEmailAndPassword(email, password);
                            }
                          }
                        }, text: 'Login'),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.black38),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ScreenCreateAccnt()));
                                },
                                child: Text('Create Account',
                                    style: GoogleFonts.roboto()))),
                      ])),
            ],
          ),
        )),
      ),
    );
  }

  goToAdminHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const AdminHome()),
        (route) => false);
  }

 

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to HomeInfo screen
      goToHome();
    } on FirebaseAuthException catch (ex) {
      error(ex);
    }
  }

  void error(ex) {
    UiHelper.customTextAlert(context, ex.code.toString());
  }

  void goToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const HomeInfo()),
    );
  }
}
