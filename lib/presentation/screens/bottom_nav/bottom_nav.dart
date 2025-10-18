import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/presentation/screens/mood/mood_page.dart';
import 'package:task_app/presentation/screens/training_calender/training_calender.dart';
import '../../widgets/bottom_nav/build_bottom_nav.dart';
import '../home/home_screen.dart';
import '../../controllers/bottom_nav/bottom_nav_controller.dart';
import '../profile/profile.dart';

class BottomNavScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  BottomNavScreen({super.key});

  final List<Widget> _pages = [
    HomeScreen(),
    TrainingCalendar(),
    MoodPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => _pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() => buildBottomNav(controller)),
    );
  }
}
