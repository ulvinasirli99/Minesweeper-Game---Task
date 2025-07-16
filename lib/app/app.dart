import 'package:flutter/material.dart';
import '../core/constant/app_constant.dart';
import '../presentation/screens/menu_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
} 