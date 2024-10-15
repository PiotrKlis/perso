import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_profile_image.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/address/address_cubit.dart';
import 'package:perso/app/widgets/address/perso_address.dart';
import 'package:perso/app/widgets/category_chips/perso_selectable_category_chips.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/perso_google_map.dart';
import 'package:perso/app/widgets/perso_add_spoken_language.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_async_text_field.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_indented_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/profile_image/image_cubit.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({
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
        BlocProvider(
          create: (context) => MapCubit(),
        ),
        BlocProvider(
          create: (context) => AddressCubit(),
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
    final profileEntity = userTypeProfileEntityPair.$2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getSections(profileEntity, userType),
    );
  }

  List<Widget> _getSections(ProfileEntity? profileEntity, UserType userType) {
    if (profileEntity != null) {
      return _getPrefilledSections(profileEntity, userType);
    } else {
      return _getEmptySections(userType);
    }
  }

  List<Widget> _getEmptySections(UserType userType) {
    return [
      const _ImageSection(),
      const _NameSection(),
      const _SurnameSection(),
      const _NicknameSection(),
      _maybeGetEmptyTrainerSection(userType),
    ];
  }

  Widget _maybeGetEmptyTrainerSection(UserType userType) {
    if (userType == UserType.trainer) {
      return const _TrainerOnlySection();
    } else {
      return Container();
    }
  }

  List<Widget> _getPrefilledSections(
    ProfileEntity profileEntity,
    UserType userType,
  ) {
    return [
      _ImageSection(imagePath: profileEntity.imagePath),
      _NameSection(name: profileEntity.name),
      _SurnameSection(surname: profileEntity.surname),
      _NicknameSection(
        nickname: profileEntity.nickname,
      ),
      _maybeGetPrefilledTrainerSection(userType, profileEntity),
    ];
  }

  Widget _maybeGetPrefilledTrainerSection(
    UserType userType,
    ProfileEntity profileEntity,
  ) {
    if (userType == UserType.trainer) {
      return _TrainerOnlySection(
        trainerEntity: profileEntity as TrainerEntity,
      );
    } else {
      return Container();
    }
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    String imagePath = '',
  }) : _imagePath = imagePath;

  final String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: Dimens.mMargin),
          child: ProfileEditProfileImage(_imagePath),
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
  const _NameSection({
    String name = '',
  }) : _name = name;

  final String _name;

  @override
  State<_NameSection> createState() => _NameSectionState();
}

class _NameSectionState extends State<_NameSection> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget._name;
    super.initState();
  }

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
                          .updateName(_nameController.text);
                    },
                  );
                  return PersoTextField(
                    maxLength: 20,
                    hintText: context.strings.name,
                    textEditingController: _nameController,
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
  const _SurnameSection({
    String surname = '',
  }) : _surname = surname;

  final String _surname;

  @override
  State<_SurnameSection> createState() => _SurnameSectionState();
}

class _SurnameSectionState extends State<_SurnameSection> {
  final surnameController = TextEditingController();

  @override
  void initState() {
    surnameController.text = widget._surname;
    super.initState();
  }

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
  const _NicknameSection({
    String nickname = '',
  }) : _nickname = nickname;

  final String _nickname;

  @override
  State<_NicknameSection> createState() => _NicknameSectionState();
}

class _NicknameSectionState extends State<_NicknameSection> {
  final userInfoProvider = getIt.get<UserInfoProvider>();
  final nicknameController = TextEditingController();

  @override
  void initState() {
    nicknameController.text = widget._nickname;
    super.initState();
  }

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
          );
          return PersoAsyncTextFormField(
            isReadOnly: widget._nickname.isNotEmpty,
            maxLength: 20,
            hintText: context.strings.nickname,
            validator: _getValidator(),
            validationDebounce: const Duration(milliseconds: 500),
            controller: nicknameController,
          );
        },
      ),
    );
  }

  Future<bool> Function(String) _getValidator() {
    final isReadOnly = widget._nickname.isNotEmpty;
    if (isReadOnly) {
      return (_) => Future.value(true);
    } else {
      return userInfoProvider.isNicknameUnique;
    }
  }
}

class _TrainerOnlySection extends StatelessWidget {
  const _TrainerOnlySection({TrainerEntity? trainerEntity})
      : _trainerEntity = trainerEntity;

  final TrainerEntity? _trainerEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getTrainerSections(_trainerEntity),
    );
  }

  List<Widget> _getTrainerSections(TrainerEntity? trainerEntity) {
    if (trainerEntity != null) {
      return _getPrefilledTrainerSections(trainerEntity);
    } else {
      return _getEmptyTrainerSections();
    }
  }

  List<Widget> _getPrefilledTrainerSections(TrainerEntity trainerEntity) {
    return [
      _AddressSection(address: trainerEntity.address),
      const _MapSection(),
      const _Divider(),
      _ShortBioSection(shortBio: trainerEntity.shortBio),
      _LongBioSection(longBio: trainerEntity.longBio),
      PersoAddSpokenLanguage(selectedLanguages: trainerEntity.languages),
      const _Divider(),
      _SelectableCategories(categories: trainerEntity.categories),
    ];
  }

  List<Widget> _getEmptyTrainerSections() {
    return [
      const _AddressSection(),
      const _MapSection(),
      const _Divider(),
      const _ShortBioSection(),
      const _LongBioSection(),
      const PersoAddSpokenLanguage(),
      const _Divider(),
      const _SelectableCategories(),
    ];
  }
}

class _SelectableCategories extends StatelessWidget {
  const _SelectableCategories({
    List<String> categories = const [],
  }) : _categories = categories;

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child: PersoSelectableCategoryChips(
            selectedCategories: _categories,
          ),
        ),
      ],
    );
  }
}

class _LongBioSection extends StatefulWidget {
  const _LongBioSection({
    String longBio = '',
  }) : _longBio = longBio;

  final String _longBio;

  @override
  State<_LongBioSection> createState() => _LongBioSectionState();
}

class _LongBioSectionState extends State<_LongBioSection> {
  final longBioController = TextEditingController();

  @override
  void initState() {
    longBioController.text = widget._longBio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      margin: const EdgeInsets.only(
        left: Dimens.xxxlMargin,
        top: Dimens.xmMargin,
        right: Dimens.xmMargin,
      ),
      child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          state.whenOrNull(
            sendData: () {
              context
                  .read<ProfileEditCubit>()
                  .updateLongBio(longBioController.text);
            },
          );
          return PersoTextField(
            hintText: context.strings.long_bio,
            isMultiLine: true,
            maxLength: 500,
            customValidator: TextFieldValidator.validateIsEmpty,
            textEditingController: longBioController,
          );
        },
      ),
    );
  }
}

class _ShortBioSection extends StatefulWidget {
  const _ShortBioSection({
    String shortBio = '',
  }) : _shortBio = shortBio;

  final String _shortBio;

  @override
  State<_ShortBioSection> createState() => _ShortBioSectionState();
}

class _ShortBioSectionState extends State<_ShortBioSection> {
  final shortBioController = TextEditingController();

  @override
  void initState() {
    shortBioController.text = widget._shortBio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
                builder: (context, state) {
                  state.whenOrNull(
                    sendData: () {
                      context
                          .read<ProfileEditCubit>()
                          .updateShortBio(shortBioController.text);
                    },
                  );
                  return PersoTextField(
                    hintText: context.strings.short_bio,
                    customValidator: TextFieldValidator.validateIsEmpty,
                    isMultiLine: true,
                    maxLength: 150,
                    textEditingController: shortBioController,
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

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.xmMargin,
        right: Dimens.xmMargin,
      ),
      child: const PersoIndentedDivider(),
    );
  }
}

class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.xmMargin),
      child: const PersoGoogleMap(
        shouldShowMarkerAtTheCenter: true,
      ),
    );
  }
}

class _AddressSection extends StatelessWidget {
  const _AddressSection({
    String address = '',
  }) : _address = address;

  final String _address;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  child: PersoAddress(
                    address: _address,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
