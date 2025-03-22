part of 'cargo_bloc.dart';

@immutable
final class CargoState extends Equatable {
  final LoadingStatus status;
  final List<CargoModel> cargos;
  final String? error;

  const CargoState({
    this.status = LoadingStatus.pure,
    this.cargos = const [],
    this.error,
  });

  CargoState copyWith({
    LoadingStatus? status,
    List<CargoModel>? cargos,
    String? error,
  }) {
    return CargoState(
      status: status ?? this.status,
      cargos: cargos ?? this.cargos,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, cargos, error];
}
