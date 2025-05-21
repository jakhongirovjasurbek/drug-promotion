import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/screens/home/args/cargo_args.dart';
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

      final data = jsonDecode(response.data);

      return CargoModel.buildList(data);
    });
  }

  Future<Either<Failure, void>> updateCargoStatus(CargoArgs args) {
    return handleRequest<void>(() async {
      await dio.patch(
        '/cargo/status',
        data: {
          "cargo_id": args.cargoId,
          "status": '${args.status.number}',
        },
      );

      return;
    });
  }

  Future<Either<Failure, void>> acceptOrder({
    required String cargoId,
    required String orderId,
    required String rowId,
    required num expectedDistance,
    required num expectedTime,
  }) {
    return handleRequest(() async {
      await dio.patch(
        '/order/start',
        data: {
          "cargo_id": cargoId,
          "order_id": orderId,
          "row_id": rowId,
          "expected_distance": expectedDistance,
          "expected_time": expectedTime
        },
      );

      return;
    });
  }

  Future<Either<Failure, void>> completeOrder({
    required String cargoId,
    required String orderId,
    required String rowId,
    required num realDistance,
    required num expectedTime,
  }) {
    return handleRequest(() async {
      await dio.patch(
        '/order/end',
        data: {
          "cargo_id": cargoId,
          "order_id": orderId,
          "row_id": rowId,
          "distance": realDistance,
        },
      );

      return;
    });
  }

  Future<Either<ServerFailure, void>> uploadOrderImage({
    required String path,
    required String cargoId,
    required String rowId,
  }) async {
    return handleRequest(() async {
      final formData = FormData();

      formData.fields.addAll({MapEntry('cargo_id', cargoId), MapEntry('row_id', rowId)});

      formData.files.add(MapEntry('image', await MultipartFile.fromFile(path)));

      await dio.post('/image', data: formData);

      return;
    });
  }
}
