import 'dart:convert';

import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';
import 'package:drugpromotion/core/methods/setup_locator.dart';
import 'package:drugpromotion/core/models/notification.dart';

final class NotificationRepository {
  final _dio = DioSettings().dio;

  Future<Either<ServerFailure, List<NotificationModel>>> getNotifications() {
    return handleRequest(() async {
      final response = await _dio.get('/notifications');

      return NotificationModel.buildList(jsonDecode(response.data));
    });
  }
}
