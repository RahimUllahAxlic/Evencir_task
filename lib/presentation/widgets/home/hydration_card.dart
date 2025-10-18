import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/config/theme/app_colors.dart';
import 'package:task_app/presentation/widgets/home/hydration_chart.dart';

class HydrationCard extends StatelessWidget {
  const HydrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "0%",
                        style: GoogleFonts.mulish(
                          color: const Color(0xFF4AB0FF),
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "Hydration",
                      style: GoogleFonts.mulish(
                        color: AppColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Log Now",
                      style: GoogleFonts.mulish(
                        color: AppColors.textColorSec,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const HydrationLineChart(progress: 0.0),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Bottom Bar
          Container(
            width: double.infinity,
            height: 43,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(27, 61, 69, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "500 ml added to water log",
              style: GoogleFonts.mulish(
                color: AppColors.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
