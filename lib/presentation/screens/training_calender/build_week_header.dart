import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/theme/app_colors.dart';

Widget buildWeekHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Week 2/8",
          style: GoogleFonts.mulish(
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "December 8-14",
              style: GoogleFonts.mulish(
                  color: AppColors.textColorSec,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "Total: 60min",
              style: GoogleFonts.mulish(
                  color: AppColors.textColorSec,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    ),
  );
}
