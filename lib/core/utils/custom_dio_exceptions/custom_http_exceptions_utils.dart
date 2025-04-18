import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class CustomHttpExceptionsUtils {
  final String _noInternetConnectionError =
      'Please check your internet connection.';
  final String unKnownError =
      'An unknown error has occurred. Please try again later';

  String? errorMsg(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
        return _noInternetConnectionError;
      case DioExceptionType.unknown:
        return unKnownError;
    }
  }
}
