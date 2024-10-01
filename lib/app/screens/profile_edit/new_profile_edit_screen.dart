import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/address/perso_address.dart';
import 'package:perso/app/widgets/category_chips/perso_selectable_category_chips.dart';
import 'package:perso/app/widgets/map/perso_google_map.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_async_text_field.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_indented_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/app/widgets/profile_image/profile_image.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileEditCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
      ],
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
    return BlocListener<ProfileEditCubit, ProfileEditState>(
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
              formKey: formKey,
              userType: userTypeProfileEntityPair.$1,
            ),
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
    final userType = userTypeProfileEntityPair.$1;
    _preFillSections(context, userTypeProfileEntityPair);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ImageSection(),
        _NameSection(),
        _SurnameSection(),
        _NicknameSection(),
        _TrainerOnlySection(
          userType: userType,
        ),
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
      context.read<ProfileEditCubit>().preFillData(userTypeProfileEntityPair);
    }
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: Dimens.mMargin),
          child: const ProfileImage(),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: Dimens.mMargin,
            left: Dimens.lMargin,
            right: Dimens.lMargin,
          ),
          child: Center(
            child: PersoButton(
              title: context.strings.upload_image,
              onTap: (context) {
                context.read<ImageCubit>().chooseImage();
              },
            ),
          ),
        ),
      ],
    );
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
      child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          if (state == const ProfileEditState.sendData()) {
            return const PersoButton(
              isLoading: true,
            );
          } else {
            return PersoButton(
              title: context.strings.confirm,
              onTap: (context) {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<ProfileEditCubit>().confirm(userType);
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
              child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
                builder: (context, state) {
                  state.whenOrNull(
                    sendData: () {
                      context
                          .read<ProfileEditCubit>()
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
      child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          state.whenOrNull(
            sendData: () {
              context
                  .read<ProfileEditCubit>()
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
      child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          state.whenOrNull(
            sendData: () {
              context
                  .read<ProfileEditCubit>()
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

class _TrainerOnlySection extends StatelessWidget {
  const _TrainerOnlySection({required this.userType});

  final UserType userType;
  //TODO: Make me great again
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: userType == UserType.trainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: Dimens.xmMargin,
                  ),
                  child: const Icon(Icons.pin_drop, size: 24),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: Dimens.xmMargin,
                    ),
                    child: PersoAddress(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xmMargin),
            child: PersoGoogleMap(),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: const PersoIndentedDivider(),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: Dimens.xmMargin,
                  ),
                  child: const Icon(
                    Icons.text_snippet,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 140,
                    margin: const EdgeInsets.only(
                      left: Dimens.xmMargin,
                    ),
                    child: PersoTextField(
                      hintText: context.strings.short_bio,
                      customValidator: TextFieldValidator.validateIsEmpty,
                      isMultiLine: true,
                      maxLength: 150,
                      textEditingController: TextEditingController(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 340,
            margin: const EdgeInsets.only(
              left: Dimens.xxxlMargin,
              top: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: PersoTextField(
              hintText: context.strings.long_bio,
              isMultiLine: true,
              maxLength: 500,
              customValidator: TextFieldValidator.validateIsEmpty,
              textEditingController: TextEditingController(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              right: Dimens.xmMargin,
            ),
            child: const PersoIndentedDivider(),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              left: Dimens.xmMargin,
            ),
            child: Text(
              context.strings.select_your_specialities,
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xsMargin),
            child: PersoSelectableCategoryChips(),
          ),
        ],
      ),
    );
  }
}
