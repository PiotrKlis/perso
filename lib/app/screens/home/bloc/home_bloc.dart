import 'package:Perso/app/screens/home/event/home_event.dart';
import 'package:Perso/app/screens/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final RegisterProvider registerProvider = GetIt.I.get<RegisterProvider>();

  HomeBloc(HomeState initialState) : super(initialState) {
    on<Init>((state, emit) async {
      print("I work!");
    });
  }
}
