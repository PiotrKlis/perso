import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:Perso/app/widgets/trainers_list/event/trainers_list_event.dart';
import 'package:Perso/app/widgets/trainers_list/state/trainers_list_state.dart';
import 'package:Perso/data/repositories/trainers/test_trainers_repository.dart';
import 'package:Perso/data/repositories/trainers/trainers_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TrainersListBloc extends Bloc<TrainersListEvent, TrainersListState> {
  final TrainersRepository trainersProvider =
      GetIt.I.get<TestTrainersRepository>();

  TrainersListBloc(TrainersListState initialState) : super(initialState) {
    on<LoadData>((event, emitter) async {
      try {
      List<TrainerCard> trainers = await trainersProvider.getTrainerCards();
      emitter(TrainersListState.content(trainers: trainers));
      } catch (error) {
        emitter(TrainersListState.error(error: error.toString()));
      }
    });
  }
}
