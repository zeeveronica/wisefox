import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:wisefox/student/features/service/base_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import 'package:wisefox/apps/utils/urls.dart';

class ApiService extends BaseService {
  @override
  Future deleteResponse(String url, var headers) async {
    dynamic responseJson;
    try {
      responseJson =
          await http.delete(Uri.parse(Url.BASEURL + url), headers: headers);
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future deleteWithBody(String url, var body) async {
    dynamic responseJson;
    try {
      Map<String, String>? headers = await SharedPreferencesHelper.getHeaders();
      responseJson =
          await http.delete(Uri.parse(url), headers: headers, body: body);
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      Map<String, String>? headers = await SharedPreferencesHelper.getHeaders();
      log("url is $url");
      final response = ReceivePort();
      await Isolate.spawn(isolate, [url, headers, response.sendPort]);
      return await response.first;
      // log("get response" + Urls.BASE_URL + url);
    } catch (e) {
      throw e;
    }
  }

  void isolate(List<dynamic> args) async {
    final url = args[0];
    final headers = args[1];
    final sendPort = args[2];
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = response;
    } catch (e) {
      throw e;
    }
    sendPort.send(responseJson);
  }

  void isolatePost(List<dynamic> args) async {
    final url = args[0];
    final headers = args[1];
    final sendPort = args[2];
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      responseJson = response;
    } catch (e) {
      throw e;
    }
    sendPort.send(responseJson);
  }

  @override
  Future patchResponse(String url, body, headers) async {
    var responseJson;
    try {
      final response = await http.patch(Uri.parse(Url.BASEURL + url),
          body: body, headers: headers);
      if (response.statusCode == 200) {
        responseJson = response;
      } else {
        responseJson = "{'message': 'error'}";
      }
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, body) async {
    var responseJson;
    try {
      Map<String, String>? headers = await SharedPreferencesHelper.getHeaders();

      final response =
          await http.post(Uri.parse(url), body: body, headers: headers);

      responseJson = response;
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future putResponse(String url, body, headers) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(Url.BASEURL + url),
          body: body, headers: headers);

      responseJson = response;
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

  @override
  Future getResponseDirect(String url, var headers) async {
    dynamic responseJson;
    try {
      responseJson = await http.get(Uri.parse(url), headers: headers);
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }
}
