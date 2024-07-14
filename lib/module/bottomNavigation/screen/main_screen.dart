import 'package:Bijak/module/bottomNavigation/controller/main_screen_controller.dart';
import 'package:Bijak/module/home/screen/home_screen.dart';
import 'package:Bijak/module/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: Colors.green,
        onTap: controller.onItemTapped,
      )),
    );
  }
}
