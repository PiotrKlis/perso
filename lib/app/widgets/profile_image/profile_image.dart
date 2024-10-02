import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/image_state.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String chosenImagePath = '';

  @override
  Widget build(BuildContext context) {
    _profileEditCubitListener(context);
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            context.read<ImageCubit>().getImageUrl();
            return const ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                width: Dimens.profileImageWidth,
                height: Dimens.profileImageHeight,
              ),
            );
          },
          imageChosen: (path) {
            chosenImagePath = path;
            return ClipOval(
              child: Image.file(
                File(path),
                width: Dimens.profileImageWidth,
                height: Dimens.profileImageHeight,
                fit: BoxFit.cover,
              ),
            );
          },
          imageFound: (String url) {
            return ClipOval(
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: Dimens.profileImageWidth,
                height: Dimens.profileImageHeight,
              ),
            );
          },
          imageNotFound: () {
            return const Icon(
              Icons.account_circle,
              size: Dimens.profileImageSize,
              color: Colors.black,
            );
          },
        );
      },
    );
  }

  void _profileEditCubitListener(BuildContext context) {
    context.watch<ProfileEditCubit>().state.whenOrNull(
      sendData: () {
        context.read<ProfileEditCubit>().updateImageUrl(chosenImagePath);
      },
    );
  }
}
