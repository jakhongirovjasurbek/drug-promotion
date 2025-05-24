import 'package:bloc/bloc.dart';
import 'package:drugpromotion/core/enums/cargo_status.dart';
import 'package:drugpromotion/core/enums/loading_status.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/repositories/cargo.dart';
import 'package:drugpromotion/screens/home/args/cargo_args.dart';
import 'package:drugpromotion/screens/home/args/order_args.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cargo_event.dart';
part 'cargo_state.dart';

class CargoBloc extends Bloc<CargoEvent, CargoState> {
  final CargoRepository repository;

  CargoBloc(this.repository) : super(CargoState()) {
    on<CargoGetItemsEvent>((event, emit) async {
      emit(state.copyWith(status: LoadingStatus.loading));

      final response = await repository.getCargoList(event.args);

      response.either(
        (failure) {
          emit(state.copyWith(
            status: LoadingStatus.loadFailure,
            error: failure.message,
          ));
        },
        (cargos) {
          emit(state.copyWith(
            status: LoadingStatus.loadSuccess,
            cargos: cargos,
          ));
        },
      );
    });

    on<CargoChangeStatusEvent>((event, emit) async {
      emit(state.copyWith(cargoStatus: LoadingStatus.loading));

      final response = await repository.updateCargoStatus(
        CargoArgs(
          status: event.status,
          cargoId: event.cargoId,
        ),
      );

      response.either(
        (failure) {
          emit(state.copyWith(
            cargoStatus: LoadingStatus.loadFailure,
            error: failure.message,
          ));
        },
        (_) {
          print('It came to success');

          final cargos = state.cargos.map((cargo) {
            if (cargo.cargoId == event.cargoId) {
              return cargo.copyWith(cargoStatus: event.status);
            }

            return cargo;
          }).toList();

          emit(state.copyWith(
            cargoStatus: LoadingStatus.loadSuccess,
            cargos: cargos,
          ));
        },
      );
    });
  }
}
