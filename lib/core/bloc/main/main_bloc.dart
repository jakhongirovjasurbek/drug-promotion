import 'package:bloc/bloc.dart';
import 'package:drugpromotion/core/repositories/firebase.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final _firebaseRepository = FirebaseRepository();

  MainBloc() : super(MainState()) {
    on<MainEvent$SendFCMToken>((event, emit) async {
      final response = await _firebaseRepository.sendFCMToken(event.token);

      response.either(
        (failure) {},
        (_) {},
      );
    });
  }
}
