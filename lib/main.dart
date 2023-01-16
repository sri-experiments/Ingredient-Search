import 'package:flutter/material.dart';
import 'package:ingredients_scanner/scan_screen.dart';
import 'package:ingredients_scanner/theme/color.dart';
import 'package:ingredients_scanner/theme/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    return MaterialApp(
      title: 'Ingredient Scanner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: lightTextTheme,
      ),
      home: const ScanScreen(),
    );
  }
}
