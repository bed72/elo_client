enum HttpMethod {
  get('get'),
  put('put'),
  post('post'),
  path('path'),
  delete('delete');

  final String value;

  const HttpMethod(this.value);
}

class ClientModel {
  final String path;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  final HttpMethod? method;

  const ClientModel({
    required this.path,
    this.body,
    this.headers,
    this.queryParams,
    this.method = HttpMethod.get,
  });
}
