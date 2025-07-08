//this class holds base urls, api methods, tokens , headers

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Constant/ApiUrlConstant/ApiUrlConstant.dart';
import '../Utils/Debugprint.dart';

class ApiClass {
  static final String _baseUrl = baseUrl;
  
  /// Creating Header With Authenticated Data
  static Future<Map<String, String>> getHeaders({isHeader = false}) async {
    DebugPrint.prt("Get Header function Called");
    //checkUserRegistration? token = await MySharedPreferences.getMobileVerificationData();
    var token = "";
    return ({
      "Content-Type": "application/json",
      ...(isHeader && token != null
          ? {
              'token': token
              //token!.responseData!.token!,
            }
          : {})
    });
  }

  /// Get Method With Header Checks
  static Future<Response> get(String endPoint, {bool isHeader = true}) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");
    DebugPrint.prt("Get API Api Url $_baseUrl$endPoint");
    var response;
    try {
      response = await http.get(Uri.parse("$_baseUrl$endPoint"), headers: headers).timeout(const Duration(seconds: 30));
    } on SocketException {
      throw "No Internet Connection";
    } on TimeoutException {
      throw 'Network Request time out';
    }
    return response;
  }

  /// POST Method With Header Checks
  static Future<Response> post(String endPoint, Map<String, dynamic> object, {bool isHeader = true}) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");
    var response;
    DebugPrint.prt("ApiUrl $_baseUrl$endPoint");
    DebugPrint.prt("data to be passed $object");
    try {
      response = await http
          .post(Uri.parse("$_baseUrl$endPoint"), body: jsonEncode(object), headers: headers)
          .timeout(const Duration(seconds: 30));
      DebugPrint.prt("Api Response http class ${response.body}");
    } on SocketException {
      throw "No Internet Connection";
    } on TimeoutException {
      throw 'Network Request time out';
    }
    return response;
  }

  /// PATCH Method With Header Checks
  static Future<Response> patch(String endPoint, Object object, {bool isHeader = true}) async {
    final headers = await getHeaders(isHeader: isHeader);
    DebugPrint.prt("Header passed $headers");
    var response;
    try {
      response = await http
          .patch(Uri.parse("$_baseUrl$endPoint"), body: object, headers: headers)
          .timeout(const Duration(seconds: 30));
    } on SocketException {
      throw "No Internet Connection";
    } on TimeoutException {
      throw 'Network Request time out';
    }
    return response;
  }

  /// DELETE Method With Header Checks
  static Future<Response> delete(String endPoint, {bool isHeader = true}) async {
    Map<String, String> headers = isHeader ? await getHeaders() : {};
    DebugPrint.prt("Header passed $headers");
    var response;
    try {
      response =
          await http.delete(Uri.parse("$_baseUrl$endPoint"), headers: headers).timeout(const Duration(seconds: 30));
    } on SocketException {
      throw "No Internet Connection";
    } on TimeoutException {
      throw 'Network Request time out';
    }
    return response;
  }
}
