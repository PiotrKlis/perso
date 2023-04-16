import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/widgets/trainers_list/event/trainers_list_event.dart';
import 'package:Perso/app/widgets/trainers_list/state/trainers_list_state.dart';
import 'package:Perso/data/trainers/firestore_trainers_provider.dart';
import 'package:Perso/data/trainers/test_trainers_repository.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TrainersListBloc extends Bloc<TrainersListEvent, TrainersListState> {
  final TrainersSource trainersSource =
      GetIt.I.get<FirestoreTrainersProvider>();

  TrainersListBloc(TrainersListState initialState) : super(initialState) {
    on<LoadData>((event, emitter) async {
      try {
        List<TrainerEntity> trainers = await trainersSource.getTrainers();
        emitter(TrainersListState.content(trainers: trainers));
      } catch (error) {
        emitter(TrainersListState.error(error: error.toString()));
      }
    });
  }
}
