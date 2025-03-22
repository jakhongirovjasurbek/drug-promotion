part of 'cargo_bloc.dart';

@immutable
sealed class CargoEvent {
  const CargoEvent();
}

final class CargoGetItemsEvent extends CargoEvent {
  final OrderArgs? args;

  const CargoGetItemsEvent({required this.args});
}
