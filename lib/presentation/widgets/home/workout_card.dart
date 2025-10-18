import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/config/theme/app_colors.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String time;
  final String duration;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.time,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: Color.fromRGBO(50, 170, 183, 1),
              width: 7,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: GoogleFonts.mulish(
                    color: AppColors.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.mulish(
                    color: AppColors.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            Image.asset("assets/icons/arrow.png"),
          ],
        ),
      ),
    );
  }
}
