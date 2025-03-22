import 'dart:convert';

import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/screens/home/args/order_args.dart';

final class CargoRepository {
  final dio = DioSettings().dio;

  Future<Either<Failure, List<CargoModel>>> getCargoList(OrderArgs? args) {
    return handleRequest<List<CargoModel>>(() async {
      final response = await dio.get(
        '/orders',
        queryParameters: switch (args != null) {
          (true) => {'cargo_status': args!.status.number},
          _ => null,
        },
      );

      print('Raw data: ${response.data}');

      print('Response data: ${jsonDecode(response.data)}');

      final data = jsonDecode(response.data);
      print('Decoded data type:${data.runtimeType} and data: $data ');

      return CargoModel.buildList(data);
    });
  }
}
