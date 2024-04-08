import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';

class ScreenCreateAccnt extends StatefulWidget {
  const ScreenCreateAccnt({super.key});

  @override
  State<ScreenCreateAccnt> createState() => _ScreenCreateAccntState();
}

class _ScreenCreateAccntState extends State<ScreenCreateAccnt> {
  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();
  bool _obscuretext1 = true;
  bool _obscuretext2 = true;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    height: 100,
                    image: AssetImage('assets/login/login_logo.png')),
                Text("Let's Create Your Account",
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        UiHelper.customTextField(
                            controller: _emailController,
                            labeltext: 'E-Mail',
                            iconData: Icons.email_rounded,
                            validate: 'Email address is required'),
                        const SizedBox(height: 20),
                        TextFormField(
                            obscureText: _obscuretext1,
                            controller: _passwordController1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text('Password',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black)),
                                prefixIcon: const Icon(Icons.security),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscuretext1 = !_obscuretext1;
                                    });
                                  },
                                  child: Icon(_obscuretext1
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 20),
                        TextFormField(
                            obscureText: _obscuretext2,
                            controller: _passwordController2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text('Password',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black)),
                                prefixIcon: const Icon(Icons.security),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscuretext2 = !_obscuretext2;
                                    });
                                  },
                                  child: Icon(_obscuretext2
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 50),
                        UiHelper.customButton(context, () {
                          if (_formkey.currentState!.validate()) {
                            createAccount();
                          }
                        }, text: 'Create Account')
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createAccount() async {
    final pass1 = _passwordController1.text;
    final pass2 = _passwordController2.text;
    final email = _emailController.text;
    if (pass1 != pass2) {
      return UiHelper.customTextAlert(context, "Password Doesn't match");
    } else {
      // ignore: unused_local_variable
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass1)
            .then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx2) => const HomeInfo()));
          return null;
        });
      } on FirebaseAuthException catch (ex) {
        error(ex);
      }
    }
  }

  error(ex) {
    UiHelper.customTextAlert(context, ex.code.toString());
  }
}
