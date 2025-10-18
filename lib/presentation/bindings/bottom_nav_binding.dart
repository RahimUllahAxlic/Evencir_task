import 'package:get/get.dart';
import '../controllers/bottom_nav/bottom_nav_controller.dart';
import '../controllers/home/home_controller.dart';
import '../controllers/training_calendar/training_calender_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}
