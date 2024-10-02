import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/profile/bloc/profile_bloc.dart';
import 'package:perso/app/screens/profile/event/profile_event.dart';
import 'package:perso/app/screens/profile/state/profile_state.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/profile_image.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class ClientProfileScreen extends StatelessWidget {
  ClientProfileScreen({super.key});

  final userProfile = getIt.get<UserInfoProvider>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileBloc()..add(const ProfileEvent.loadData()),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileEditCubit(),
        ),
      ],
      child: const _ClientProfileScreenBuilder(),
    );
  }
}

class _ClientProfileScreenBuilder extends StatelessWidget {
  const _ClientProfileScreenBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          data: (profileEntity) {
            return _ClientProfileScreenContent(
              clientEntity: profileEntity as ClientEntity,
            );
          },
        );
      },
    );
  }
}

class _ClientProfileScreenContent extends StatelessWidget {
  const _ClientProfileScreenContent({required ClientEntity clientEntity})
      : _clientEntity = clientEntity;

  final ClientEntity _clientEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(
        isTitleCentered: true,
        title: '@${_clientEntity.nickname}',
        actionIcon: Icons.edit,
        onActionIconClick: _navigateToProfileEdit,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.xlMargin),
                    child: const ProfileImage(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.mMargin),
                    child: Text(
                      '${_clientEntity.name} ${_clientEntity.surname}',
                      style: ThemeText.mediumTitleBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(Dimens.mMargin),
            child: PersoButton(
              title: context.strings.logout,
              onTap: (context) async {
                context.read<ProfileBloc>().add(const ProfileEvent.logout());
                context.replaceNamed(ScreenNavigationKey.home);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProfileEdit(BuildContext context) {
    context.pushNamed(
      ScreenNavigationKey.profileEditClient,
      extra: (UserType.client, _clientEntity),
    );
  }
}
