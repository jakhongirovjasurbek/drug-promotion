import 'package:dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';

Future<Either<ServerFailure, T>> handleRequest<T>(
  Future<T> Function() callback,
) async {
  try {
    final response = await callback();

    return Right(response);
  } on DioException catch (error) {
    return Left(ServerFailure(message: error.response?.data ?? ''));
  } catch (error) {
    return Left(ServerFailure(message: '$error'));
  }
}
