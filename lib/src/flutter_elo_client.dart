import 'flutter_elo_client_platform_interface.dart';

import 'package:flutter_elo_client/src/models/client_model.dart';

class EloClient {
  Future<String?> makeRequest({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    HttpMethod method = HttpMethod.get,
  }) async {
    return await EloClientPlatform.instance.makeRequest(
      params: ClientModel(
        path: path,
        body: body,
        headers: headers,
        queryParams: queryParams,
        method: method,
      ),
    );
  }
}
