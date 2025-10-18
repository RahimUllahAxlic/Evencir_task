import 'package:get/get.dart';
import '../../presentation/bindings/bottom_nav_binding.dart';
import '../../presentation/screens/bottom_nav/bottom_nav.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/mood/mood_page.dart';
import '../../presentation/screens/profile/profile.dart';
import '../../presentation/screens/training_calender/training_calender.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.bottomNav;

  static final routes = [
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => BottomNavScreen(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.training,
      page: () => TrainingCalendar(),
    ),
    GetPage(
      name: AppRoutes.mood,
      page: () => MoodPage(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
  ];
}
