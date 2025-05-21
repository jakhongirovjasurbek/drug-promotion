part of 'cargo_bloc.dart';

@immutable
sealed class CargoEvent {
  const CargoEvent();
}

final class CargoGetItemsEvent extends CargoEvent {
  final OrderArgs? args;

  const CargoGetItemsEvent({required this.args});
}

final class CargoChangeStatusEvent extends CargoEvent {
  final String cargoId;
  final CargoStatus status;

  const CargoChangeStatusEvent({
    required this.cargoId,
    required this.status,
  });
}
