import 'package:get/get.dart';

class StepsFormRegisterController extends GetxController {
  var stepIndex = 0;

  onStepCancel() {
    if (stepIndex > 0) {
      stepIndex -= 1;
    }
    update();
  }

  onStepContinue() {
    stepIndex += 1;
    update();
  }

  onStepTapped(int index) {
    stepIndex = index;
    update();
  }
}
