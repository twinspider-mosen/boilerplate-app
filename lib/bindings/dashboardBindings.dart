import 'package:general_app/controllers/dashboard/dashboardController.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Dashboardcontroller());
  }
}
