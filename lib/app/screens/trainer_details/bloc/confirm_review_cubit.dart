import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/trainer_details/state/confirm_review_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/trainers/trainers_service/firestore_trainers_service.dart';

class ConfirmReviewCubit extends Cubit<ConfirmReviewState> {
  ConfirmReviewCubit() : super(const ConfirmReviewState.initial());
  final _trainersService = getIt.get<FirestoreTrainersService>();

  Future<void> addReview(String review, String trainerId, double rating) async {
    emit(const ConfirmReviewState.loading());
    try {
      await _trainersService.addReview(review, trainerId, rating);
      emit(const ConfirmReviewState.added());
    } catch (error) {
      emit(ConfirmReviewState.error(error.toString()));
    }
  }
}
