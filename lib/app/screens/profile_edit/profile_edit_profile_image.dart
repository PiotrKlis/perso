import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/profile_image.dart';

class ProfileEditProfileImage extends StatelessWidget {
  const ProfileEditProfileImage(this._imagePath, {super.key});

  final String _imagePath;

  @override
  Widget build(BuildContext context) {
    _profileEditListener(context);
    return ProfileImage(imagePath: _imagePath);
  }

  void _profileEditListener(BuildContext context) {
    var imagePath = '';
    context.watch<ImageCubit>().state.whenOrNull(
      imageChosen: (path) {
        imagePath = path;
      },
    );
    context.watch<ProfileEditCubit>().state.whenOrNull(
      sendData: () {
        context.read<ProfileEditCubit>().updateImageUrl(imagePath);
      },
    );
  }
}
