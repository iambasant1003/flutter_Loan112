import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../Utils/AppConfig.dart';
import '../Utils/Debugprint.dart';

class ApiClass {
  static final String _baseUrl = AppConfig.baseUrl;

  final Dio _dio;

  ApiClass()
      : _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  /// Creating Header With Authenticated Data
  Future<Map<String, String>> getHeaders({isHeader = false}) async {
    DebugPrint.prt("Get Header function Called");

    // You can fetch token here, for now hardcoded empty
    var token = "";

    final headers = <String, String>{
      "Content-Type": "application/json",
    };

    if (isHeader && token.isNotEmpty) {
      headers['token'] = token;
    }

    return headers;
  }

  /// GET
  Future<Response> get(String endPoint, {bool isHeader = true}) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");
    DebugPrint.prt("Get API URL $_baseUrl$endPoint");

    try {
      final response = await _dio.get(
        endPoint,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST
  Future<Response> post(
      String endPoint,
      Map<String, dynamic> object, {
        bool isHeader = true,
      }) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");
    DebugPrint.prt("ApiUrl $_baseUrl$endPoint");
    DebugPrint.prt("data to be passed $object");

    try {
      final response = await _dio.post(
        endPoint,
        data: jsonEncode(object),
        options: Options(headers: headers),
      );
      DebugPrint.prt("Api Response http class ${response.data}");
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PATCH
  Future<Response> patch(
      String endPoint,
      Object object, {
        bool isHeader = true,
      }) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");

    try {
      final response = await _dio.patch(
        endPoint,
        data: object,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE
  Future<Response> delete(
      String endPoint, {
        bool isHeader = true,
      }) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");

    try {
      final response = await _dio.delete(
        endPoint,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Private error handler
  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Network Request timed out';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'No Internet Connection';
    } else {
      return e.message ?? 'Unexpected error';
    }
  }
}
