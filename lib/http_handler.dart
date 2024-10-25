import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:watt/watt.dart';

import 'app_router.dart';
import 'utils/http_response_utils.dart';

class HttpHandler {
  HttpHandler({this.loaderState});

  final ValueNotifier<LoaderState>? loaderState;

  void start() {
    if (loaderState == null) {
      DialogUtil.showLoadingDialog(AppRouter.navigatorKey.currentContext!);
    } else {
      loaderState!.value = LoaderState.loading;
    }
  }

  void stop() {
    if (loaderState == null) {
      AppRouter.pop();
    } else {
      loaderState!.value = LoaderState.none;
    }
  }

  void handleException(
    Object e,
    StackTrace stackTrace, {
    bool ignoreAuthentication = false,
  }) {
    if (loaderState == null) {
      AppRouter.pop();
    }

    if (e is Response) {
      loaderState?.value = LoaderState.unknownError;
      HttpResponseUtils.showErrorMessage(
          AppRouter.navigatorKey.currentContext!, e, ignoreAuthentication);
      return;
    }

    if (e is SocketException) {
      loaderState?.value = LoaderState.noInternet;
      DialogUtil.showNoInternetDialog(AppRouter.navigatorKey.currentContext!);
      return;
    }

    loaderState?.value = LoaderState.unknownError;
    SnackbarUtil.showUnknownErrorSnackbar(
      AppRouter.navigatorKey.currentContext!,
      e: e,
      stackTrace: stackTrace,
    );
  }
}
