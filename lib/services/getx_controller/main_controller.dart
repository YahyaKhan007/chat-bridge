import 'package:get/get.dart';

class ChatBridgeMainController extends GetxController {
  Rx<bool> addInterets = false.obs;
  RxList interestedLanguagelist = [].obs;

// * clear Data
  clearData() {
    addInterets.value = false;
    interestedLanguagelist.clear();
  }
}
