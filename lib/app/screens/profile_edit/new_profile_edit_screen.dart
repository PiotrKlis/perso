import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/profile_edit/confirm_profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/confirm_profile_edit_state.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_async_text_field.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class NewProfileEditScreen extends StatelessWidget {
  const NewProfileEditScreen({
    required (
      UserType userType,
      ProfileEntity? profileEntity,
    ) userTypeProfileEntityPair,
    super.key,
  }) : _userTypeProfileEntityPair = userTypeProfileEntityPair;

  final (UserType, ProfileEntity?) _userTypeProfileEntityPair;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ConfirmProfileEditCubit(),
      child: _EditProfileScreenContent(_userTypeProfileEntityPair),
    );
  }
}

class _EditProfileScreenContent extends StatelessWidget {
  _EditProfileScreenContent(this.userTypeProfileEntityPair);

  final formKey = GlobalKey<FormState>();
  final (UserType, ProfileEntity?) userTypeProfileEntityPair;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmProfileEditCubit, ConfirmProfileEditState>(
      listener: (context, state) {
        state.whenOrNull(
          editSuccess: () => context.replaceNamed(
            ScreenNavigationKey.home,
          ),
          profileCreated: () => context.clearAndNavigate(
            ScreenNavigationKey.profileCreationSuccess,
          ),
        );
      },
      child: Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: context.strings.edit_profile,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: _FieldSections(userTypeProfileEntityPair),
                ),
              ),
            ),
            _ConfirmButtonSection(
                formKey: formKey, userType: userTypeProfileEntityPair.$1),
          ],
        ),
      ),
    );
  }
}

class _FieldSections extends StatelessWidget {
  const _FieldSections(this.userTypeProfileEntityPair);

  final (UserType, ProfileEntity?) userTypeProfileEntityPair;

  @override
  Widget build(BuildContext context) {
    _preFillSections(context, userTypeProfileEntityPair);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NameSection(),
        _SurnameSection(),
        _NicknameSection(),
      ],
    );
  }

  void _preFillSections(
    BuildContext context,
    (UserType, ProfileEntity?) userTypeProfileEntityPair,
  ) {
    final userType = userTypeProfileEntityPair.$1;
    final profileEntity = userTypeProfileEntityPair.$2;
    if (profileEntity != null) {
      final userTypeProfileEntityPair = (userType, profileEntity);
      context
          .read<ConfirmProfileEditCubit>()
          .preFillData(userTypeProfileEntityPair);
    }
  }
}

class _ConfirmButtonSection extends StatelessWidget {
  const _ConfirmButtonSection({
    required this.formKey,
    required this.userType,
  });

  final GlobalKey<FormState> formKey;
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.xmMargin),
      child: BlocBuilder<ConfirmProfileEditCubit, ConfirmProfileEditState>(
        builder: (context, state) {
          if (state == const ConfirmProfileEditState.sendData()) {
            return const PersoButton(
              isLoading: true,
            );
          } else {
            return PersoButton(
              title: context.strings.confirm,
              onTap: (context) {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<ConfirmProfileEditCubit>().confirm(userType);
                }
              },
            );
          }
        },
      ),
    );
  }
}

class _NameSection extends StatefulWidget {
  @override
  State<_NameSection> createState() => _NameSectionState();
}

class _NameSectionState extends State<_NameSection> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.lMargin),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.xmMargin,
            ),
            child: const Icon(Icons.person, size: 24),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: Dimens.xmMargin,
                right: Dimens.xmMargin,
              ),
              child:
                  BlocBuilder<ConfirmProfileEditCubit, ConfirmProfileEditState>(
                builder: (context, state) {
                  state.whenOrNull(
                    sendData: () {
                      context
                          .read<ConfirmProfileEditCubit>()
                          .updateName(nameController.text);
                    },
                    preFillData: (userTypeProfileEntityPair) {
                      setState(() {
                        nameController.text = userTypeProfileEntityPair.$2.name;
                      });
                    },
                  );
                  return PersoTextField(
                    maxLength: 20,
                    hintText: context.strings.name,
                    textEditingController: nameController,
                    customValidator: TextFieldValidator.validateIsEmpty,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurnameSection extends StatefulWidget {
  @override
  State<_SurnameSection> createState() => _SurnameSectionState();
}

class _SurnameSectionState extends State<_SurnameSection> {
  final surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xxxlMargin,
        top: Dimens.lMargin,
        right: Dimens.xmMargin,
      ),
      child: BlocBuilder<ConfirmProfileEditCubit, ConfirmProfileEditState>(
        builder: (context, state) {
          state.whenOrNull(
            sendData: () {
              context
                  .read<ConfirmProfileEditCubit>()
                  .updateSurname(surnameController.text);
            },
            preFillData: (userTypeProfileEntityPair) {
              setState(() {
                surnameController.text = userTypeProfileEntityPair.$2.surname;
              });
            },
          );
          return PersoTextField(
            maxLength: 20,
            textEditingController: surnameController,
            hintText: context.strings.surname,
            customValidator: TextFieldValidator.validateIsEmpty,
          );
        },
      ),
    );
  }
}

class _NicknameSection extends StatefulWidget {
  @override
  State<_NicknameSection> createState() => _NicknameSectionState();
}

class _NicknameSectionState extends State<_NicknameSection> {
  final userInfoProvider = getIt.get<UserInfoProvider>();

  final nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xxxlMargin,
        top: Dimens.lMargin,
        right: Dimens.xmMargin,
      ),
      //TODO: Find different, non-hacky way of async validation way
      child: BlocBuilder<ConfirmProfileEditCubit, ConfirmProfileEditState>(
        builder: (context, state) {
          state.whenOrNull(
            sendData: () {
              context
                  .read<ConfirmProfileEditCubit>()
                  .updateNickname(nicknameController.text);
            },
            preFillData: (userTypeProfileEntityPair) {
              setState(() {
                nicknameController.text = userTypeProfileEntityPair.$2.nickname;
              });
            },
          );
          return PersoAsyncTextFormField(
            maxLength: 20,
            hintText: context.strings.nickname,
            validator: userInfoProvider.isNicknameUnique,
            validationDebounce: const Duration(milliseconds: 500),
            controller: nicknameController,
          );
        },
      ),
    );
  }
}
