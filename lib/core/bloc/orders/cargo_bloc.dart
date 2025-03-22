import 'package:bloc/bloc.dart';
import 'package:drugpromotion/core/enums/loading_status.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/repositories/cargo.dart';
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
          print('Here we are: $cargos');

          emit(state.copyWith(
            status: LoadingStatus.loadSuccess,
            cargos: cargos,
          ));
          print('Status: ${state.status}');
        },
      );
    });
  }
}
