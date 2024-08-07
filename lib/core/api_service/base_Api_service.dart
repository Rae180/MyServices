import 'dart:io';

abstract class BaseApiService {
  Future<dynamic> getRequest({required String url});
  Future<dynamic> getRequestAuth({required String url});
  Future<dynamic> postRequest(
      {required String url, required Map<String, dynamic> jsonBody});
  Future<dynamic> postRequestAuth(
      {required String url, required Map<String, dynamic> jsonBody});
  Future<dynamic> multipart(
      {required String url,
      required Map<String, dynamic> jsonBody,
      File? file});
  Future<dynamic> multipart2({
    required String url,
    required Map<String, dynamic> jsonBody,
    required String? attributeName,
    required List<File>? files,
  });
  Future<dynamic> delete ({
    required String url,
  });
  
}
