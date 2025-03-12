import 'package:dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';

Future<Either<ServerFailure, T>> handleRequest<T>(
  Future<T> Function() callback,
) async {
  try {
    print('Sending request...');
    final response = await callback();

    print('Request is sent...');
    return Right(response);
  } on DioException catch (error) {
    print('URL: ${error.requestOptions.uri.path}/${error.requestOptions.path}');

    print('Error message: ${error.error}');

    print('Error data: ${error.message}');

    print('Error type: ${error.type}');

    print('Error response: ${error.response}');

    return Left(ServerFailure(message: error.message ?? ''));
  } catch (error) {
    return Left(ServerFailure(message: '$error'));
  }
}
