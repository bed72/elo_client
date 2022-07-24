import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_elo_client/src/models/client_model.dart';
import 'package:flutter_elo_client/src/flutter_elo_client_method_channel.dart';

import 'mock/lucario_mock.dart';

void main() {
  MethodChannelEloClient platform = MethodChannelEloClient();
  const MethodChannel channel = MethodChannel('flutter_elo_client');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler(
      (MethodCall methodCall) async => lucarioMock.toString(),
    );
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('Must call makeRequest method with a valid response', () async {
    final response = await platform.makeRequest(
        params: const ClientModel(path: 'any')) as List;

    expect(response, isA<List<dynamic>?>());
  });
}
