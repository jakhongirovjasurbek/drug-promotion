import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:drugpromotion/core/dio/interceptor.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DioSettings {
  final _dioBaseOptions = BaseOptions(
    baseUrl: 'https://drugpromotion.uz/ka_test/hs/delivery',
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    validateStatus: (status) => status != null && status <= 400,
  );

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  Dio get dio => Dio(_dioBaseOptions)
    ..addSentry(
      failedRequestStatusCodes: [SentryStatusCode.range(300, 599)],
    )
    ..interceptors.addAll([
      const RequestInterceptor(),
      ChuckerDioInterceptor(),
    ]);
}
