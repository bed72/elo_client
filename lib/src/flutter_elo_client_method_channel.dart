import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'flutter_elo_client_platform_interface.dart';

import 'package:flutter_elo_client/src/models/client_model.dart';

/// An implementation of [EloClientPlatform] that uses method channels.
class MethodChannelEloClient extends EloClientPlatform {
  final String request = "request";

  @visibleForTesting
  final methodChannel = const MethodChannel('br.com.elo7.flutter_elo_client');

  @override
  Future<String?> makeRequest({required ClientModel params}) async {
    try {
      final response = await methodChannel.invokeListMethod(request, {
        'path': params.path,
        'body': params.body,
        'headers': params.headers,
        'queryParams': params.queryParams,
        'method': params.method?.value,
      });

      return response?.first ?? 'Something went wrong!';
    } on PlatformException catch (exception) {
      return exception.message;
    }
  }
}
