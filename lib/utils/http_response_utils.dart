import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:watt/watt.dart';

class HttpResponseUtils {
  static showErrorMessage(
      BuildContext context, Response response, bool ignoreNotFound) {
    if (response.statusCode == 404 && response.request!.method == "GET") {
      return;
    }

    final dataMap = json.decode(response.body);

    final errors = dataMap["errors"];
    if (errors != null && errors is Map<String, dynamic>) {
      final errorKeys = errors.keys.toList();
      if (errorKeys.isNotEmpty) {
        final firstError = errors[errorKeys.first].first;
        if (firstError.isNotEmpty) {
          return DialogUtil.showAlertDialog(
            context,
            title: response.statusCode >= 500 && response.statusCode <= 599
                ? "Error"
                : "Warning",
            message: firstError,
          );
        }
      }
    }

    final message = dataMap["message"];
    if (message != null && message is String) {
      return DialogUtil.showAlertDialog(
        context,
        title: response.statusCode >= 500 && response.statusCode <= 599
            ? "Error"
            : "Warning",
        message: message,
      );
    }

    return DialogUtil.showAlertDialog(
      context,
      title: "Error",
      message: "Unknown error",
    );
  }

  static bool isSuccess(Response response, bool ignoreNotFound) {
    return response.statusCode >= 200 && response.statusCode <= 299 ||
        (ignoreNotFound ? response.statusCode == 404 : false);
  }

  static bool isNotFound(Response response) {
    return response.statusCode == 404;
  }
}
