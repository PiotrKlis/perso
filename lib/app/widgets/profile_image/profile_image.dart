import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/image_state.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
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
                fit: BoxFit.fill,
              ),
            );
          },
          imageNotFound: () {
            return const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: Dimens.profileImageSize,
            );
          },
        );
      },
    );
  }
}
