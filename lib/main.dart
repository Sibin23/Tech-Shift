import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/home.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/onboardScreens/onboard1.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Shift',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade800),
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
    Future.delayed(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx2) => const HomeInfo()),
            (route) => false);
      } else {
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Splash/splash screen new.png'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300, right: 10, left: 10),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('TECH SHIFT', style: TextStyling.title1W),
                      const SizedBox(
                        height: 200,
                      ),
                      Text('LETS CRAFT YOUR DREAM PC',
                          style: TextStyling.titile2W),
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
      ),
    );
  }
}
