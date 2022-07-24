import 'package:flutter_test/flutter_test.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:flutter_elo_client/src/models/client_model.dart';

import 'package:flutter_elo_client/src/flutter_elo_client.dart';
import 'package:flutter_elo_client/src/flutter_elo_client_method_channel.dart';
import 'package:flutter_elo_client/src/flutter_elo_client_platform_interface.dart';

import 'mock/lucario_mock.dart';

class MockFlutterEloClientPlatform
    with MockPlatformInterfaceMixin
    implements EloClientPlatform {
  @override
  Future<String?> makeRequest({required ClientModel params}) {
    throw UnimplementedError();
  }
}

void main() {
  final EloClientPlatform initialPlatform = EloClientPlatform.instance;

  test('$MethodChannelEloClient is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEloClient>());
  });

  test('Must call makeRequest method with a valid response', () async {
    EloClient clientPlugin = EloClient();
    MockFlutterEloClientPlatform fakePlatform = MockFlutterEloClientPlatform();
    EloClientPlatform.instance = fakePlatform;

    expect(
      await clientPlugin.makeRequest(path: 'any'),
      lucarioMock.toString(),
    );
  });
}
