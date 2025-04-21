import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/endpoints.dart';

class CallPage extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  final String userId;
  final String userName;

  const CallPage({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  Future<Map> _fetchCallConfig() async {
    ApiResponse response = await Api.send(
      EndPoints.videoCall,
      params: [doctorId],
    );

    if (response.success) {
      return response.data!;
    } else {
      throw Exception(response.message ?? 'Failed to get call configuration');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _fetchCallConfig(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
            );
          }

          final config = snapshot.data!;
          return SafeArea(
            child: ZegoUIKitPrebuiltCall(
              appID: config['app_id'] as int,
              appSign: config['app_sign'] as String,
              userID: userId,
              userName: userName,
              callID: config['call_id'] as String,
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}