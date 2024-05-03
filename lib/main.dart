//import 'package:agricapp/pages/home_page.dart';
import 'package:agricapp/pages/onboardinpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_cart/flutter_cart.dart';

void main() async {
  // Ensure that Firebase is initialized before runApp is called
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);
  runApp(const MyApp()); // Replace MyApp with your main widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agric App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: const OnboardingPage(),
    );
  }
}
