import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:seriestv_jobcity/common/logger.dart';
import 'package:seriestv_jobcity/data/api/api_constant.dart';

class ApiBase {
  final Client _client;

  ApiBase(this._client);

  final log = getLogger('ApiBase');

  Future<dynamic> get(String url) async {
    try {
      final uriBase = Uri.parse('${ApiConstant.baseUrl}$url');
      log.i('Api Get, url $uriBase');

      final response = await _client.get(
        uriBase,
        headers: {'Content-Type': 'application/json'},
      );
      return _returnResponse(response);
    } on SocketException catch (e) {
      log.e(e.message);
      throw SocketException(e.message);
    } on Exception catch (e) {
      log.e(e.toString());
      throw Exception(e);
    }
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? params}) async {
    try {
      final uriBase = Uri.parse('${ApiConstant.baseUrl}$url');
      log.i('Api Post, url $uriBase, params $params');

      final response = await _client.post(
        uriBase,
        body: json.encode(params),
        headers: {'Content-Type': 'application/json'},
      );
      return _returnResponse(response);
    } on SocketException catch (e) {
      log.e(e.message);
      throw SocketException(e.message);
    } on Exception catch (e) {
      log.e(e.toString());
      throw Exception(e);
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw Exception(response.reasonPhrase);
      case 401:
      case 403:
        throw Exception(response.reasonPhrase);
      case 500:
        throw Exception(
            'Error ocurred while communication with server with statusCode ${response.statusCode}');
    }
  }
}
