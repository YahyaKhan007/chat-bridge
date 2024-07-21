import 'package:bloc/bloc.dart';
import 'package:chat_bridge/models/models.dart';
import 'package:chat_bridge/services/auth_service.dart/auth_service.dart';
import 'package:chat_bridge/services/chat_service/chat_service.dart';
import 'package:chat_bridge/services/db_service/db_service.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/services/routes/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;
  final DataBaseService dbService;
  final AuthService authService;
  ChatBloc(
      {required this.chatService,
      required this.dbService,
      required this.authService})
      : super(const ChatState()) {
    on<InitializeChat>(_initializeChat);
  }

  void _initializeChat(InitializeChat event, Emitter<ChatState> emit) async {
    final mainController = Get.find<ChatBridgeMainController>();
    mainController.isLoading.value = true;
    final chatroomModel = await chatService.getChatroomModel(
      targetUser: event.targetUser,
      userModel: mainController.currentUserModel.value!,
    );

    Get.toNamed(
      RouterHelper.chatRoom,
      arguments: {
        'chatModel': chatroomModel,
        'targetUser': event.targetUser,
      },
    );
  }
}
