import 'package:http/http.dart' as http;

class MultiPartFile {
  final String field;
  final String filePath;

  MultiPartFile({
    required this.field,
    required this.filePath,
  });

  MultiPartFile copyWith({
    String? field,
    String? filePath,
  }) {
    return MultiPartFile(
      field: field ?? this.field,
      filePath: filePath ?? this.filePath,
    );
  }
}

class HttpService {
  final String? userAgent;

  HttpService({this.userAgent});

  String? bearerToken;

  static const String apiKey = 'NZEUCFu6s59ysPXfzHgUW9XoTRcCXb3I5TdE3WIO';
  static const String client = 'PERS_210';
  static const String authorization = 'Basic UEVSU18yMTA6R3VCcGpWVUk2ZVAz';
  static const String apiVersion = 'v200';
  static const String territory = 'UK';
  static const String geolocation = '51.5104;-0.132358';
  static const String deviceDatetime = '2024-10-24T11:57:04.072Z';

  Future<http.Response> get(String url) async {
    return http.get(
      Uri.parse(url),
      headers: _createHeaders(),
    );
  }

  Future<http.Response> post(String url, String? data) async {
    return await http.post(
      Uri.parse(url),
      body: data,
      headers: _createHeaders(),
    );
  }

  Future<http.Response> put(String url, String? data) async {
    return http.put(
      Uri.parse(url),
      body: data,
      headers: _createHeaders(),
    );
  }

  Future<http.Response> delete(String url) async {
    return http.delete(
      Uri.parse(url),
      headers: _createHeaders(),
    );
  }

  Future<http.Response> multiPartPost(
    String url, {
    Map<String, String>? fields,
    List<MultiPartFile>? fileFields,
  }) async {
    final request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(_createHeaders());

    if (fileFields != null) {
      for (final fileField in fileFields) {
        final file = await http.MultipartFile.fromPath(
          fileField.field,
          fileField.filePath,
        );

        request.files.add(file);
      }
    }

    if (fields != null) {
      request.fields.addAll(fields);
    }

    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

  Map<String, String> _createHeaders() {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (userAgent != null) "User-Agent": userAgent!,
      if (bearerToken != null) "Authorization": "Bearer $bearerToken",
      "x-api-key": apiKey,
      "client": client,
      "authorization": authorization,
      "api-version": apiVersion,
      "territory": territory,
      "geolocation": geolocation,
      "device-datetime": deviceDatetime,
    };

    return headers;
  }
}
