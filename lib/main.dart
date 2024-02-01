import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Home_screen/home_page.dart';
import 'package:prosample_1/onboardScreens/onboard1.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3400), () {
      final user = FirebaseAuth.instance.currentUser;
     if(user != null){
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx2) =>const ScreenHome()), (route) => false);
     }
     else{
       Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const OnboardScreen1()));
     }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            const SizedBox(
              child: Image(
                image: AssetImage(
                  'assets/Splash/splash screen new.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230, right: 10, left: 10),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TECH SHIFT',
                        style:
                            GoogleFonts.lora(color: Colors.white, fontSize: 25)),
                    const SizedBox(
                      height: 270,
                    ),
                    Text('LETS CRAFT YOUR DREAM PC',
                        style: GoogleFonts.carterOne(
                            color: Colors.white, fontSize: 25)),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: Lottie.asset(
                          'assets/Splash/Animation - 1706686055581.json',
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
