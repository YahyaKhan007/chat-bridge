// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// import '../../../../utils/constants.dart';

// class CallPage extends StatelessWidget {
//   const CallPage({super.key, required this.callID});
//   final String callID;

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID: Constants
//           .zegoAppId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign: Constants
//           .zegoAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: 'user_id_khan',
//       userName: 'user_name_khan',
//       callID: callID,
//       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../utils/constants.dart';

class CallPage extends StatelessWidget {
  final String callID;
  final String userID;
  final String userName;

  const CallPage({
    Key? key,
    required this.callID,
    required this.userID,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Constants.zegoAppId,
      appSign: Constants.zegoAppSign,
      userID: userID,
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
