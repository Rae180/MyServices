import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:start/core/utils/helpers/decode_response.dart';

class NetworkApiServiceHttp implements BaseApiService{
  @override
  Future getRequest({required String url}) async{
  try {
    //    String? lan = PreferenceUtils.getString(
    //   'LANGUAGE',
    // );
    // String lan = '';
    //   String? token = '';
      //PreferenceUtils.getString('TOKEN');
      print('url $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "content-type": "application/json; charset=utf-8",
          'api': '1.0.0',
          'X-Requested-With': "XMLHttpRequest",
          //"Locale": lan,
          "Accept": "application/json",
        //  if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('status code ${response.statusCode}');
      print('the body : ${response.body}');
      final decodedResponse = DecodeResponse.decode(response);

      return decodedResponse;
    } on SocketException {
      throw ExceptionSocket();
    } on FormatException {
      throw ExceptionFormat();
    } on TimeoutException {
      throw ExceptionTimeout();
    } on HandshakeException {
      throw ExceptionHandshake();
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } on Exception {
      throw ExceptionOther();
    }
  }



  @override
  Future multipart({required String url, required Map<String, dynamic> jsonBody, File? file})async {
     try {
     // String? token = '';
      //PreferenceUtils.getString('TOKEN');
      print('url $url');
      print('the posted body ${jsonBody.toString()}');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request = jsonToFormData(request, jsonBody);
      
      if (file!= null) {
        request.files.add(await http.MultipartFile.fromPath(
            'image',
            file.path,
          ));
      }
      print('request ${request.fields.toString()}');
      
      request.headers['X-Requested-With'] = "XMLHttpRequest";
      request.headers['content-type'] = "application/json; charset=utf-8";
     // request.headers['Authorization'] = "Bearer $token";
      final response = await request.send();
      final decodedResponse =
          DecodeResponse.decodeMultiplePartResponse(response);
      return decodedResponse;
    } on SocketException {
      throw ExceptionSocket();
    } on FormatException {
      throw ExceptionFormat();
    } on TimeoutException {
      throw ExceptionTimeout();
    } on HandshakeException {
      throw ExceptionHandshake();
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } on Exception {
      throw ExceptionOther();
    }
  }

  @override
  Future multipart2({required String url, required Map<String, dynamic> jsonBody, required String? attributeName, required List<File>? files})async {
    try {
      String? token = '';
      //PreferenceUtils.getString('TOKEN');
      print('url $url');
      print('the posted body ${jsonBody.toString()}');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${'ApiConstants.baseAppUrl'}$url'),
      );
      request = jsonToFormData(request, jsonBody);
      print('request ${request.fields.toString()}');
      if (files != null) {
        for (var element in files) {
          print('file: ${element.path}');
          request.files.add(await http.MultipartFile.fromPath(
            attributeName!,
            element.path,
          ));
        }
      }
     

      request.headers['X-Requested-With'] = "XMLHttpRequest";
      request.headers['content-type'] = "application/json; charset=utf-8";
      request.headers['Authorization'] = "Bearer $token";
      final response = await request.send();
      final decodedResponse =
          DecodeResponse.decodeMultiplePartResponse(response);
      return decodedResponse;
    } on SocketException {
      throw ExceptionSocket();
    } on FormatException {
      throw ExceptionFormat();
    } on TimeoutException {
      throw ExceptionTimeout();
    } on HandshakeException {
      throw ExceptionHandshake();
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } on Exception {
      throw ExceptionOther();
    }
  }

  @override
  Future postRequest({required String url, required Map<String, dynamic> jsonBody}) async{
    try {
    //    String? lan = PreferenceUtils.getString(
    //   'LANGUAGE',
    // );
    // lan ??= 'en';
      // String? token = PreferenceUtils.getString('TOKEN');
      print('url $url');
      print('the posted body ${jsonBody.toString()}');
      final response =
          await http.post(Uri.parse(url),
              headers: {
                "content-type": "application/json; charset=utf-8",
                'api': '1.0.0',
                'X-Requested-With': "XMLHttpRequest",
              //  "Locale": lan,
                "Accept": "application/json",
              //  if (token != null) 'Authorization': 'Bearer $token',
              },
              body: json.encode(jsonBody));

      print('status code ${response.statusCode}');
      print('the body is sisiisisisis : ${response.body}');
      final decodedResponse = DecodeResponse.decode(response);

      return decodedResponse;
    } on SocketException {
      throw ExceptionSocket();
    } on FormatException {
      throw ExceptionFormat();
    } on TimeoutException {
      throw ExceptionTimeout();
    } on HandshakeException {
      throw ExceptionHandshake();
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } on Exception {
      throw ExceptionOther();
    }
  }

  @override
  Future postlogout({required String url}) {
    // TODO: implement postlogout
    throw UnimplementedError();
  }
}



jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}