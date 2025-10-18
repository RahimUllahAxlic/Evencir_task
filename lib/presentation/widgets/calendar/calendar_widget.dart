import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/presentation/utils/calendar_utils.dart';

import '../../../config/theme/app_colors.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime initialSelected;
  final ValueChanged<DateTime> onSelect;

  const CalendarBottomSheet({
    super.key,
    required this.initialSelected,
    required this.onSelect,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialSelected;
    _focusedDay = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final weekStart = CalendarUtils.startOfWeek(_selectedDay!);
    final weekEnd = CalendarUtils.endOfWeek(_selectedDay!);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (d) =>
                  CalendarUtils.isSameDate(d, _selectedDay!),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
                widget.onSelect(selected);
                // Navigator.pop(context); //Close after selecting
              },
              onPageChanged: (focused) => setState(() => _focusedDay = focused),

              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                leftChevronIcon:
                    Icon(Icons.chevron_left, color: Colors.white70),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.white70),
              ),

              calendarStyle: CalendarStyle(
                defaultTextStyle:
                    GoogleFonts.mulish(color: AppColors.textColorSec),
                weekendTextStyle:
                    GoogleFonts.mulish(color: AppColors.textColorSec),
                outsideTextStyle:
                    GoogleFonts.mulish(color: Colors.white.withOpacity(0.2)),
                selectedDecoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.greenLight,
                  ),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.greenLight.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),

              // Custom week highlight
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final inWeek =
                      !day.isBefore(weekStart) && !day.isAfter(weekEnd);
                  return Container(
                    decoration: inWeek
                        ? BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.08),
                            shape: BoxShape.circle,
                          )
                        : null,
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  final inWeek =
                      !day.isBefore(weekStart) && !day.isAfter(weekEnd);
                  return Container(
                    decoration: inWeek
                        ? BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.06),
                            shape: BoxShape.circle,
                          )
                        : null,
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white24),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
