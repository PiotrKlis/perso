import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/utils/logger.dart';
import 'package:perso/app/widgets/profile_image/image_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/image/image_repository.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(const ImageState.initial());
  final _imageRepository = getIt.get<ImageRepository>();
  final _userSessionModel = getIt.get<UserSessionModel>();

  Future<void> getImageUrl() async {
    final userId = _userSessionModel.user?.uid ?? '';
    try {
      final imageUrl = await _imageRepository.getImageUrl(userId);
      if (imageUrl.isNotEmpty) {
        emit(ImageState.imageFound(imageUrl));
      } else {
        emit(const ImageState.imageNotFound());
      }
    } catch (error, stackTrace) {
      Logger.error(error, stackTrace);
      emit(const ImageState.imageNotFound());
    }
  }

  Future<void> chooseImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: Dimens.profileImageResolutionHeight,
      maxWidth: Dimens.profileImageResolutionWidth,
    );
    if (pickedImage != null) {
      final url = pickedImage.path;
      emit(ImageState.imageChosen(url));
    } else {
      emit(const ImageState.imageNotFound());
    }
  }
}
