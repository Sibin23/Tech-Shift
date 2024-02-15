import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/create_account.dart';
import 'package:prosample_1/User/forgot_password.dart';
import 'package:prosample_1/admin/home.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
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
                                        builder: (ctx) => const ScreenPassword()));
                              },
                              child: Text('Forgot Password?',
                                  style: GoogleFonts.poppins(
                                      color: Colors.purple)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor: Colors.purple),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    goToHome(_emailController.text.toString(),
                                        _passwordController.text.toString());
                                  }
                                },
                                child: Text('Login',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)))),
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

  void goToHome(String email, String password) async {
    // ignore: unused_local_variable
    UserCredential? usercredential;
    try {
      if (email == 'admin@gmail.com' && password == 'admin123') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx2) => const AdminHome()));
      }

      usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return Navigator.push(
            context, MaterialPageRoute(builder: (ctx2) => const HomeInfo()));
      });
    } on FirebaseAuthException catch (ex) {
      
      // ignore: void_checks, use_build_context_synchronously
      return UiHelper.customAlertBox(context, ex.code.toString());
    }
  }
}
