import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pricescout_pro/screens/home.dart';
import 'package:pricescout_pro/screens/splash.dart';
import 'firebase_options.dart';

import 'screens/auth.dart';

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
      title: 'PriceScout Pro',
      theme: ThemeData(useMaterial3: true,
      primarySwatch: Colors.purple,),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        
        if (snapshot.hasData) {
          return const PricescoutProScreen();
        }
        return const AuthScreen();
      },)
      //const AuthScreen(),
    );
  }
}