import 'dart:io';

abstract class BaseApiService{
  Future<dynamic> getApiResponse(String url, {bool? token});
  Future<dynamic> deleteApiResponse(String url, {bool? token});
  Future<dynamic> postApiResponse(String url, dynamic data, {bool? token});
  Future<dynamic> postWithFiles(String url, dynamic data, Map<String,File> files, {bool? token});
}