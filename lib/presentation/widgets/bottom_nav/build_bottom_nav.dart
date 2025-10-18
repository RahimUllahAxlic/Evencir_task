import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildBottomNav(controller) {
  const inactiveColor = Color.fromRGBO(102, 102, 126, 1);
  const activeColor = Colors.white;

  final icons = [
    "assets/icons/nutrition.png",
    "assets/icons/plan.png",
    "assets/icons/mood.png",
    "assets/icons/profile.png",
  ];
  final labels = ["Nutrition", "Plan", "Mood", "Profile"];

  return Container(
    height: 80,
    decoration: const BoxDecoration(
      color: Color(0xFF0E0E13),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(icons.length, (index) {
        final isSelected = controller.currentIndex.value == index;

        return GestureDetector(
          onTap: () => controller.changeIndex(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icons[index],
                height: 26,
                width: 26,
                color: isSelected ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 6),
              Text(
                labels[index],
                style: GoogleFonts.mulish(
                  color: isSelected ? activeColor : inactiveColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        );
      }),
    ),
  );
}
