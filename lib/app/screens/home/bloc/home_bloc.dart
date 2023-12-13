import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/home/event/home_event.dart';
import 'package:perso/app/screens/home/state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial());
}
