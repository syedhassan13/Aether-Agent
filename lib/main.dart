import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(const AetherAgentApp());
}

class AetherAgentApp extends StatelessWidget {
  const AetherAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      // Define the dark theme globally
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppConstants.primaryColor,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.surfaceColor,
          titleTextStyle: TextStyle(color: AppConstants.textColor, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: AppConstants.primaryColor),
        ),
        colorScheme: ColorScheme.dark(
          primary: AppConstants.primaryColor,
          secondary: AppConstants.primaryColor,
          surface: AppConstants.surfaceColor,
          background: AppConstants.backgroundColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}