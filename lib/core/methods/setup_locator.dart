import 'dart:async';

import 'package:drugpromotion/core/enums/auth_status.dart';
import 'package:drugpromotion/core/helpers/storage_repository.dart';
import 'package:drugpromotion/core/repositories/authentication.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();

  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(
            controller: StreamController<AuthenticationStatus>(),
          ));
}
