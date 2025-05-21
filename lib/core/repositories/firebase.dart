import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';

final class FirebaseRepository {
  final _dio = DioSettings().dio;

  Future<Either<ServerFailure, void>> sendFCMToken(String token) async {
    return handleRequest<void>(() async {
      await _dio.post('/fb_token', data: {'token': token});

      return;
    });
  }
}
