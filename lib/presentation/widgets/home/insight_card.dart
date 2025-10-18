import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/config/theme/app_colors.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String subtitle;
  final double progress;
  final Color? accentColor;

  const InsightCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.subtitle,
    required this.progress,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: GoogleFonts.mulish(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                  ),
                ),
                Text(
                  unit,
                  style: GoogleFonts.mulish(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.mulish(
                color: AppColors.textColorSec,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 40),
            title == "Calories"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '2500',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 6,
                          child: Stack(
                            children: [
                              // Background
                              Container(
                                width: double.infinity,
                                color: Colors.white.withOpacity(0.08),
                              ),

                              FractionallySizedBox(
                                widthFactor: progress.clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(123, 189, 226, 1),
                                        Color.fromRGBO(105, 192, 177, 1),
                                        Color.fromRGBO(96, 193, 152, 1),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: GoogleFonts.mulish(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
