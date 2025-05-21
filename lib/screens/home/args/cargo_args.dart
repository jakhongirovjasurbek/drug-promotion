import 'package:drugpromotion/core/enums/cargo_status.dart';

final class CargoArgs {
  final CargoStatus status;
  final String cargoId;

  const CargoArgs({required this.status, required this.cargoId});
}
