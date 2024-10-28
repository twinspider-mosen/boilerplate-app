import 'package:general_app/Services/connectivity_service.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionManagerController());
  }
}
