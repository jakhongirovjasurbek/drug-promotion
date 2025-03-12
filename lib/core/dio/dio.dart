import 'package:dio/dio.dart';
import 'package:drugpromotion/core/dio/interceptor.dart';

class DioSettings {
  final _dioBaseOptions = BaseOptions(
    baseUrl: 'http://109.94.175.101/ka_test/hs/delivery',
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    validateStatus: (status) => status != null && status <= 400,
  );

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  Dio get dio => Dio(_dioBaseOptions)
    ..interceptors.addAll([
      const RequestInterceptor(),
    ]);
}
