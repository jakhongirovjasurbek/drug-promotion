import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectivityInfo with EquatableMixin {
  Future<bool> get connected;

  const ConnectivityInfo();
}

class NetworkInfoImpl extends ConnectivityInfo {
  const NetworkInfoImpl();

  @override
  Future<bool> get connected async {
    return await InternetConnectionChecker.instance.hasConnection;
  }

  Stream<InternetConnectionStatus> get connectionStatus =>
      InternetConnectionChecker.instance.onStatusChange;

  @override
  List<Object?> get props => [connected, connectionStatus];
}
