import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drugpromotion/assets/constants.dart';
import 'package:drugpromotion/core/helpers/storage_repository.dart';
import 'package:flutter/foundation.dart';

class RequestInterceptor extends Interceptor {
  const RequestInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response!.statusCode == HttpStatus.unauthorized) {}

    if (kDebugMode) {
      print('''
      DioFailure:\n
      Path: ${err.requestOptions.path}\n
      Message: ${err.message}\n
      Exception type: ${err.type}\n
      Error: ${err.error}\n
      Data: ${err.response?.data}\n
      Request options: ${err.requestOptions.data}\n
      
      ''');
    }
    return handler.reject(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = StorageRepository.getString(AppConstants.accessTokenKey);

    options.headers.addAll({
      'Accept-Language': StorageRepository.getString('language', defValue: 'uz'),
      if (!options.headers.keys.contains('without_token'))
        if (token.isNotEmpty) 'Authorization': token,
    });

    print('''
    Request headers: ${options.headers}\n
    Request path: ${options.path}\n
    ''');

    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final statusCode = response.statusCode ?? 0;

    if (statusCode >= 200 && statusCode < 300) {
      handler.next(response);
    } else {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: response.data,
        ),
        true,
      );
    }
  }
}
