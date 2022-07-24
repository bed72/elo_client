import 'flutter_elo_client_method_channel.dart';

import 'package:flutter_elo_client/src/models/client_model.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class EloClientPlatform extends PlatformInterface {
  /// Constructs a EloClientPlatform.
  EloClientPlatform() : super(token: _token);

  static final Object _token = Object();

  static EloClientPlatform _instance = MethodChannelEloClient();

  /// The default instance of [EloClientPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterEloClient].
  static EloClientPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EloClientPlatform] when
  /// they register themselves.
  static set instance(EloClientPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> makeRequest({required ClientModel params}) async {
    throw UnimplementedError('client() has not been implemented.');
  }
}
