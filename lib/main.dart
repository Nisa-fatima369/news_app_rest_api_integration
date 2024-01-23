
import 'package:flutter/material.dart';
import 'package:news_app_rest_api_integration/screens/splash_screen.dart';

void main() {
  runApp(
   const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEWS APP',
      home: SplashScreen(),
    );
  }
}
