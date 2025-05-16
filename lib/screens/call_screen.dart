import 'package:flutter/material.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/endpoints.dart';

class CallPage extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  final String callID;

  const CallPage({
    Key? key,
    required this.doctorId,
    required this.callID,
    required this.doctorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 198575597,
        appSign:
            '14f337175fa62a9a58882baa14e0edb1e08cf45bf31d1c3ca500c939ec31fd13',
        userID: '1',
        userName: '123',
        callID: '123',
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
