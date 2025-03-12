import 'dart:async';

import 'package:drugpromotion/core/enums/auth_status.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/models/auth_user.dart';

final class AuthenticationRepository {
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
    return Right(AuthUserModel(
      id: 'id1',
      username: 'username',
      phoneNumber: 'phone number',
      email: 'email',
    ));
  }
}
