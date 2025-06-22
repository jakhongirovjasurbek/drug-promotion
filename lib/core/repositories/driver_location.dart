import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';

final class DriverLocationRepository {
  final dio = DioSettings().dio;

  Future<Either<Failure, void>> postDriverLocation(
      num latitude, num longitude) {
    return handleRequest<void>(() async {
      await dio.post(
        '/driver/location',
        data: {"latitude": latitude, "longitude": longitude},
      );

      return;
    });
  }
}
