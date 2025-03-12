import 'package:dio/dio.dart';
import 'package:drugpromotion/core/dio/dio.dart';
import 'package:drugpromotion/core/failure/failure.dart';
import 'package:drugpromotion/core/helpers/dartz.dart';
import 'package:drugpromotion/core/methods/handle_request.dart';
import 'package:drugpromotion/screens/login/args/args.dart';

final class LoginRepository {
  final dio = DioSettings().dio;

  Future<Either<ServerFailure, String>> login(LoginArgs args) {
    return handleRequest<String>(() async {
      final response = await dio.post(
        '/auth',
        options: Options(headers: {'without-token': true}),
        data: {
          'user': args.user,
          'password': args.password,
        },
      );

      print('This is token: ${response.data}');

      return response.data['token'];
    });
  }
}
