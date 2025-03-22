import 'package:dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:flutter/foundation.dart';

Future<Either<ServerFailure, T>> handleRequest<T>(
  Future<T> Function() callback,
) async {
  try {
    final response = await callback();

    return Right(response);
  } on DioException catch (error, stacktrace) {
    if (kDebugMode) {
      print('Error message: $error\n Stacktrace: $stacktrace');
    }

    return Left(ServerFailure(message: error.message ?? ''));
  } catch (error, stacktrace) {
    if (kDebugMode) {
      print('Error message: $error\n Stacktrace: $stacktrace');
    }

    return Left(ServerFailure(message: '$error'));
  }
}
