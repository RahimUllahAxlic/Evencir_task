import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_app/config/theme/app_colors.dart';

class WeekSelector extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const WeekSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final weekDays =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: weekDays.map((day) {
        final isSelected = DateUtils.isSameDay(day, selectedDate);
        final isToday = DateUtils.isSameDay(day, now);

        return GestureDetector(
          onTap: () => onDateSelected(day),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('E').format(day).toUpperCase(),
                style: GoogleFonts.mulish(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.calendarDate,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isToday ? AppColors.greenLight : Colors.transparent,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  day.day.toString(),
                  style: GoogleFonts.mulish(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isToday)
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: AppColors.greenLight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
