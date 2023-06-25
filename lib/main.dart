import 'package:chrome_home_page/colors.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color(0xff132D46),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        canvasColor: Color(0xff132D46),
        primaryColor: primary,
        colorScheme: ColorScheme.dark(
          primary: primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
