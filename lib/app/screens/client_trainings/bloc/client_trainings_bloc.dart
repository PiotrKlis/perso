import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/client_trainings/event/client_trainings_event.dart';
import 'package:perso/app/screens/client_trainings/state/client_trainings_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';

class ClientTrainingBloc extends Bloc<ClientTrainingEvent, ClientTrainingState> {
  // final RegisterProvider registerProvider = getIt.get<RegisterProvider>();

  ClientTrainingBloc() : super(const ClientTrainingState.initial()) {
    on<LoadTrainings>((event, emitter) async {

    });
  }
}
