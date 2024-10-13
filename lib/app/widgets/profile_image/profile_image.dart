import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/image_state.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
    String imagePath = '',
  }) : _imagePath = imagePath;

  final String _imagePath;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String chosenImagePath = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            if (widget._imagePath.isEmpty) {
              context.read<ImageCubit>().getImageUrl();
              return const ColoredBox(
                color: Colors.transparent,
                child: SizedBox(
                  width: Dimens.profileImageWidth,
                  height: Dimens.profileImageHeight,
                ),
              );
            } else {
              return networkImage(widget._imagePath);
            }
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
          imageFound: networkImage,
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

  ClipOval networkImage(String url) {
    return ClipOval(
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: Dimens.profileImageWidth,
        height: Dimens.profileImageHeight,
      ),
    );
  }
}
