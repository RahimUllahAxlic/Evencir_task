import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/config/theme/app_colors.dart';
import '../../controllers/mood/mood_controller.dart';
import '../../widgets/mood/mood_ring.dart';

class MoodPage extends StatelessWidget {
  MoodPage({super.key});
  final MoodController controller = Get.put(MoodController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1216),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 16),
                    child: Text('Mood',
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w400,
                          fontSize: 32,
                          color: AppColors.textColor,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: Text('Start your day',
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.textColor,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 32),
                    child: Text('How are you feeling at the\nMoment?',
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: AppColors.textColor,
                        )),
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const MoodRing(size: 260),
                        Obx(() {
                          final asset = controller.assetPath;
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF14171C),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(asset, fit: BoxFit.contain),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Label
                  Center(
                    child: Obx(
                      () => Text(controller.label,
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            color: AppColors.textColor,
                          )),
                    ),
                  ),

                  const Spacer(),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // handle continue
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset("assets/images/top.png"),
        ],
      ),
    );
  }
}
