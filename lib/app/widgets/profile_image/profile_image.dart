import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, String?>(
      builder: (context, url) {
        if (url != null) {
          return Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: ClipOval(
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        } else {
          return const Icon(
            Icons.account_circle,
            size: 200,
          );
        }
      },
    );
  }
}
