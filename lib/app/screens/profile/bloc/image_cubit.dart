import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/image/image_repository.dart';

class ImageCubit extends Cubit<String?> {
  ImageCubit() : super(null);
  final imageRepository = getIt.get<ImageRepository>();
  final userSessionModel = getIt.get<UserSessionModel>();

  // Business logic methods
  void getImageUrl() async {
    final userId = userSessionModel.user?.uid ?? '';
    final imageUrl = await imageRepository.getImageUrl(userId);

    if (imageUrl.isNotEmpty) {
      emit(imageUrl);
    } else {
      emit(null);
    }
  }
}
