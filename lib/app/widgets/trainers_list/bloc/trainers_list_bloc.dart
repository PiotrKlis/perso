import 'package:perso/app/widgets/trainers_list/event/trainers_list_event.dart';
import 'package:perso/app/widgets/trainers_list/state/trainers_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/data/trainers/firestore_trainers_provider.dart';
import 'package:perso/data/trainers/trainers_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainersListBloc extends Bloc<TrainersListEvent, TrainersListState> {
  final TrainersSource _trainersSource = getIt.get<FirestoreTrainersProvider>();

  TrainersListBloc(TrainersListState initialState) : super(initialState) {
    on<LoadData>((event, emitter) async {
      try {
        List<TrainerEntity> trainers =
            await _trainersSource.getAllTrainersData();
        emitter(TrainersListState.content(trainers: trainers));
      } catch (error) {
        emitter(TrainersListState.error(error: error.toString()));
      }
    });
  }
}
