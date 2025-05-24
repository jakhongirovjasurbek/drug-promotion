import 'dart:async';
import 'dart:convert';

import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/enums/auth_status.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';
import 'package:drugpromotion/core/models/auth_user.dart';

final class AuthenticationRepository {
  final dio = DioSettings().dio;

  AuthenticationRepository({
    required StreamController<AuthenticationStatus> controller,
  }) : _controller = controller;

  final StreamController<AuthenticationStatus> _controller;

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(milliseconds: 1500));
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<Either<Exception, AuthUserModel>> getUser() async {
    return handleRequest<AuthUserModel>(() async {
      final response = await dio.get('/user');

      final data = jsonDecode(response.data);

      return AuthUserModel.fromJson(data);
    });
  }
}
