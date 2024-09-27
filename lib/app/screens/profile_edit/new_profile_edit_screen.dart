import 'package:flutter/material.dart';
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
    final userType = _userTypeProfileEntityPair.$1;
    final profileEntity = _userTypeProfileEntityPair.$2;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NameSection(),
                    _SurnameSection(),
                    _NicknameSection(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.xmMargin),
            child: PersoButton(
              title: 'Confirm',
            ),
          ),
        ],
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
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
              child: PersoTextField(
                maxLength: 20,
                hintText: context.strings.name,
                textEditingController: nameController,
                customValidator: TextFieldValidator.validateIsEmpty,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurnameSection extends StatelessWidget {
  final surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xxxlMargin,
        top: Dimens.lMargin,
        right: Dimens.xmMargin,
      ),
      child: PersoTextField(
        maxLength: 20,
        textEditingController: surnameController,
        hintText: context.strings.surname,
        customValidator: TextFieldValidator.validateIsEmpty,
      ),
    );
  }
}

class _NicknameSection extends StatelessWidget {
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
      child: PersoAsyncTextFormField(
        maxLength: 20,
        hintText: context.strings.nickname,
        validator: userInfoProvider.isNicknameUnique,
        validationDebounce: const Duration(milliseconds: 500),
        controller: nicknameController,
      ),
    );
  }
}
