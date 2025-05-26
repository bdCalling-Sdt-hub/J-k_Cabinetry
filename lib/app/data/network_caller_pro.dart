import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

import 'package:mime_type/mime_type.dart';

import '../../common/data/models/error_response_model.dart';


class NetworkResponse2 {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String errorMessage;

  NetworkResponse2({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

class MultipartFileBody {
  final String field;
  final File file;

  MultipartFileBody(this.field, this.file);
}

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class NetworkCallerPro {
  final Logger _logger = Logger();

  Future<NetworkResponse2> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    String? token,
    List<MultipartFileBody>? files,
  }) async {
    try {
      if (queryParams != null && queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
            .join('&');
        url = '$url?$queryString';
      }

      final headers = <String, String>{
        'Authorization': token != null ? 'Bearer $token' : '',
        //'Authorization': token ?? '',
        'Content-Type': files != null ? 'multipart/form-data' : 'application/json',
      };
      //..removeWhere((key, value) => value.isEmpty);


      _logRequest(url, headers, body);

      http.Response response;

      if (files != null && files.isNotEmpty) {
        response = await _sendMultipartRequest(url, method, headers, body, files);
      } else {
        final uri = Uri.parse(url);
        final encodedBody = body != null ? jsonEncode(body) : null;

        switch (method) {
          case HttpMethod.GET:
            response = await http.get(uri, headers: headers);
            break;
          case HttpMethod.POST:
            response = await http.post(uri, headers: headers, body: encodedBody);
            break;
          case HttpMethod.PUT:
            response = await http.put(uri, headers: headers, body: encodedBody);
            break;
          case HttpMethod.PATCH:
            response = await http.patch(uri, headers: headers, body: encodedBody);
            break;
          case HttpMethod.DELETE:
            response = await http.delete(uri, headers: headers, body: encodedBody);
            break;
        }
      }

      return _processResponse(url, response);
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse2(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<http.Response> _sendMultipartRequest(
      String url,
      HttpMethod method,
      Map<String, String> headers,
      Map<String, dynamic>? body,
      List<MultipartFileBody> files,
      ) async {
    var request = http.MultipartRequest(method.name, Uri.parse(url));
    //final request = http.MultipartRequest(method.name, Uri.parse(url));
    // ..headers.addAll(headers)
    // ..fields.addAll(body?.map((k, v) => MapEntry(k, v.toString())) ?? {});
    headers.remove('Content-Type');
    request.headers.addAll(headers);


    /// comment by me 👇
    // for (var file in files) {
    //   final mimeType = mime(file.file.path);
    //   request.files.add( http.MultipartFile(
    //     file.field,
    //     file.file.readAsBytes().asStream(),
    //     file.file.lengthSync(),
    //     filename: file.file.path.split('/').last,
    //     contentType: mimeType != null ? MediaType.parse(mimeType) : null,
    //   ),);
    // }


    // Add files
    for (var file in files) {
      final mimeType = mime(file.file.path);
      final mimeTypeData = mimeType?.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          file.field,
          file.file.path,
          contentType: mimeTypeData != null
              ? MediaType(mimeTypeData[0], mimeTypeData[1])
              : MediaType('application', 'octet-stream'),
        ),
      );
    }



    final streamed = await request.send();
    return await http.Response.fromStream(streamed);
  }

  NetworkResponse2 _processResponse(String url, http.Response response) {
    _logResponse(url, response.statusCode, response.headers, response.body);
    try {
      final data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse2(isSuccess: true, statusCode: response.statusCode, responseData: data);
      } else {
        final error = ErrorResponseModel.fromJson(data);
        return NetworkResponse2(isSuccess: false, statusCode: response.statusCode, errorMessage: error.msg);
      }
    } catch (_) {
      return NetworkResponse2(isSuccess: false, statusCode: response.statusCode, errorMessage: 'Invalid JSON response');
    }
  }

  void _logRequest(String url, [Map<String, dynamic>? headers, Map<String, dynamic>? body]) {
    _logger.i('REQUEST => $url\nHEADERS => $headers\nBODY => $body');
  }

  void _logResponse(String url, int statusCode, Map<String, String>? headers, String body, [String? error]) {
    if (error != null) {
      _logger.e('URL => $url\nERROR => $error');
    } else {
      _logger.i('RESPONSE => $url\nSTATUS => $statusCode\nHEADERS => $headers\nBODY => $body');
    }
  }
}
