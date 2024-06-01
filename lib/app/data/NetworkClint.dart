import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';

const String BaseUrl = "http://138.68.188.126:8000/";

class MethodType {
  static const String Post = "POST";
  static const String Get = "GET";
  static const String Put = "PUT";
  static const String Delete = "DELETE";
  static const String Patch = "PATCH";
}

class NetworkClient {
  static NetworkClient? _shared;

  NetworkClient._();

  static NetworkClient get getInstance => _shared = _shared ?? NetworkClient._();

  final dio = Dio();

  Map<String, dynamic> getAuthHeaders({String? tokenRegister}) {
    Map<String, dynamic> authHeaders = Map<String, dynamic>();
    GetStorage box = GetStorage();
    String token = "";
    if (box.read('user_token') != null) {
      token = box.read('user_token');
      print(token);
      print('tokennnnnnnn');
    }
    if (tokenRegister != null) {
      dio.options.headers["Authorization"] = "Bearer $tokenRegister";
    } else {
      if (!isNullEmptyOrFalse(token)) {
        dio.options.headers["Authorization"] = "Bearer $token";
      } else {
        authHeaders["Content-Type"] = "application/json";
      }
    }

    return authHeaders;
  }

  Map<String, dynamic> getAuthHeadersForVerify(String token) {
    Map<String, dynamic> authHeaders = Map<String, dynamic>();

    // } else {
    dio.options.headers["Authorization"] = "Bearer $token";
    // } else {
    authHeaders["Content-Type"] = "application/json";
    // }

    return authHeaders;
  }

  Future callApi({
    // BuildContext? context,
    required String baseUrl,
    // required String command,
    required String method,
    var params,
    Map<String, dynamic>? headers,
    Function(dynamic response, String message)? successCallback,
    Function(dynamic message, String statusCode)? failureCallback,
    Function()? timeOutCallback,
  }) async {
    print(baseUrl);
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      failureCallback!("", "No Internet Connection");
      getDialog(title: "Error", desc: "No Internet Connection.");
    }

    dio.options.validateStatus = (status) {
      return true;
    };
    dio.options.connectTimeout = Duration(seconds: 15); //5s
    dio.options.receiveTimeout = Duration(seconds: 15);

    if (headers != null) {
      for (var key in headers.keys) {
        dio.options.headers[key] = headers[key];
      }
    }

    switch (method) {
      case MethodType.Post:
        try {
          print('Api call pass in try');
          Response response = await dio.post(
            baseUrl,
            data: params,
            options: Options(headers: {'Content-Type': 'application/json'}),
          );
          parseResponse(response, successCallback: successCallback!, failureCallback: failureCallback!);
        } on DioError catch (e) {
          print("Network Client Function: $e");
          timeOutCallback!();
          print(e.toString());
        }

        break;
      case MethodType.Patch:
        Response response = await dio.patch(baseUrl, data: params);
        parseResponse(response, successCallback: successCallback!, failureCallback: failureCallback!);
        break;

      case MethodType.Get:
        Response response = await dio.get(baseUrl, queryParameters: params);
        parseResponse(response, successCallback: successCallback!, failureCallback: failureCallback!);
        break;

      case MethodType.Put:
        Response response = await dio.put(baseUrl, data: params);
        parseResponse(response, successCallback: successCallback!, failureCallback: failureCallback!);
        break;

      case MethodType.Delete:
        Response response = await dio.delete(baseUrl, data: params);
        parseResponse(response, successCallback: successCallback!, failureCallback: failureCallback!);
        break;

      default:
    }
  }

  parseResponse(Response response, {Function(dynamic response, String message)? successCallback, Function(dynamic statusCode, String message)? failureCallback}) {
    String message = "response.data['message']";
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 203) {
      if (isNullEmptyOrFalse(response.data)) {
        successCallback!(response.statusCode, message);
        return;
      }
      if (response.data is Map<String, dynamic> || response.data is List<dynamic>) {
        successCallback!(response.data, message);
        return;
      } else if (response.data is List<Map<String, dynamic>>) {
        successCallback!(response.data, response.statusMessage.toString());
        return;
      } else {
        failureCallback!(response.data, response.statusMessage.toString());
        return;
      }
    } else {
      failureCallback!(response.data, response.statusMessage.toString());
      if (response.statusCode == 401) {
        Toasty.showtoast(response.statusMessage.toString());
        Get.offAllNamed(Routes.LOGIN);
      }
      return;
    }
  }

  void hideDialog(bool isProgress, BuildContext context) {
    if (isProgress) {}
  }

  getDialog({String title = "Error", String desc = "Some Thing went wrong...."}) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      content: Text(desc),
      buttonColor: Colors.black,
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
