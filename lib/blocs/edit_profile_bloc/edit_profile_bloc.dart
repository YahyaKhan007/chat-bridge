import 'package:bloc/bloc.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/services/routes/routes.dart';
import 'package:chat_bridge/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final PickerService pickerService;
  final DataBaseService dataBaseService;
  EditProfileBloc(this.pickerService, this.dataBaseService)
      : super(const EditProfileState()) {
    on<AddProfilePicEvent>(_addProfilePicture);
    on<UpdateUserDetails>(_updateuserDetails);
  }

  void _updateuserDetails(
      UpdateUserDetails event, Emitter<EditProfileState> emit) async {
    final mainController = Get.find<ChatBridgeMainController>();
    final res = await dataBaseService.updateUserDetails(
        country: event.country,
        city: event.city,
        nativeLanguage: event.nativeLanguage,
        interestedLanguages: event.interestedLanguages,
        photo: "mainController.pickedImage.value!.path");
    if (res) {
      mainController.currentUserModel.value = null;
      Get.offAllNamed(RouterHelper.dashboard);
    }
  }

  void _addProfilePicture(
      AddProfilePicEvent event, Emitter<EditProfileState> emit) async {
    final mainControler = Get.find<ChatBridgeMainController>();
    XFile? xFile;
    switch (event.key) {
      case 'camera':
        xFile = await pickerService.pickImageFromCamera();
        break;
      case 'gallery':
        xFile = await pickerService.pickImageFromGalllery();
        break;
    }

    mainControler.pickedImage.value = xFile;
  }
}
