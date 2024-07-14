// main.dart

import 'package:Bijak/module/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade50
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}




