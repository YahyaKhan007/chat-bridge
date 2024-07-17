import 'package:chat_bridge/models/models.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatBridgeMainController extends GetxController {
  Rx<bool> addInterets = false.obs;
  Rxn<UserModel> currentUserModel = Rxn<UserModel>(null);
  RxList interestedLanguagelist = [].obs;
  Rxn<XFile> pickedImage = Rxn<XFile>(null);
  RxInt currentIndex = 0.obs;

// * clear Data
  clearData() {
    addInterets.value = false;
    interestedLanguagelist.clear();
    currentUserModel.value = null;
    pickedImage.value = null;
  }
}
