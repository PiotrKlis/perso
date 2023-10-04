import 'package:Perso/app/screens/trainer_details/event/trainer_details_event.dart';
import 'package:Perso/app/screens/trainer_details/state/trainer_details_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/trainers/firestore_trainers_provider.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:Perso/data/training_request/training_request_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerDetailsBloc
    extends Bloc<TrainerDetailsEvent, TrainerDetailsState> {
  final TrainersSource _trainersProvider =
  getIt.get<FirestoreTrainersProvider>();
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  TrainerDetailsBloc() : super(const TrainerDetailsState.initial()) {
    on<LoadData>((event, emitter) async {
      try {
        final TrainerEntity trainer = await _trainersProvider.getTrainerData(
            event.trainerId);
        final UserType? userType = await _userInfoProvider.getUserType();
        emitter(TrainerDetailsState.content(trainer, userType));
      } catch (error) {
        emitter(TrainerDetailsState.error(error.toString()));
      }
    });

    on<AddReview>((event, emitter) async {});
  }
}
