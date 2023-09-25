import 'dart:io';

import 'package:Perso/app/models/client_data.dart';
import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/app/screens/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:Perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:Perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/perso_async_text_field.dart';
import 'package:Perso/app/widgets/perso_autocomplete.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_chips_list.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key, required UserType userType})
      : _userType = userType;

  final UserType _userType;
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _shortBioController = TextEditingController();
  final _fullBioController = TextEditingController();
  final _spokenLanguageRowWidget = SpokenLanguageRowWidget();
  final _addressWidget = PersoAutocomplete();
  final _persoChipsList = PersoChipsList();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileEditBloc(const ProfileEditState.initial()),
      child: Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Edit ${widget._userType.name} profile"),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    margin: const EdgeInsets.only(top: Dimens.bigMargin),
                    child: _image == null
                        ? const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 120.0,
                          )
                        : ClipOval(
                            child: Image.file(
                              File(_image!.path),
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.bigMargin),
                    child: Center(
                        child: PersoButton(
                      title: AppLocalizations.of(context)!.upload_image,
                      onTap: (context) {
                        _getImage();
                      },
                    ))),
                Visibility(
                  visible: widget._userType == UserType.trainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.bigMargin,
                              right: Dimens.normalMargin),
                          child: const PersoDivider()),
                      Container(
                          margin:
                              const EdgeInsets.only(top: Dimens.normalMargin),
                          child: _spokenLanguageRowWidget),
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              right: Dimens.bigMargin),
                          child: const PersoDivider()),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.normalMargin),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin),
                            child: const Icon(Icons.person, size: 24.0)),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin,
                                right: Dimens.normalMargin),
                            child: PersoTextField(
                                title: AppLocalizations.of(context)!.name,
                                textEditingController: _nameController,
                                customValidator:
                                    TextFieldValidator.validateIsEmpty),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(
                      left: Dimens.substantialMargin,
                      top: Dimens.bigMargin,
                      right: Dimens.normalMargin),
                  child: PersoTextField(
                      textEditingController: _surnameController,
                      title: AppLocalizations.of(context)!.surname,
                      customValidator: TextFieldValidator.validateIsEmpty),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: Dimens.substantialMargin,
                      top: Dimens.bigMargin,
                      right: Dimens.normalMargin),
                  //TODO: Find different, non-hacky way of async validation way
                  child: PersoAsyncTextFormField(
                      hintText: AppLocalizations.of(context)!.nickname,
                      validator: (value) =>
                          widget._userInfoProvider.isNicknameUnique(value),
                      validationDebounce: const Duration(milliseconds: 500),
                      controller: _nicknameController),
                ),
                Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.normalMargin, right: Dimens.normalMargin),
                    child: const PersoDivider()),
                Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.normalMargin, right: Dimens.normalMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin),
                            child: const Icon(Icons.pin_drop, size: 24.0)),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: Dimens.normalMargin),
                              child: _addressWidget),
                        ),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.normalMargin, right: Dimens.normalMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin),
                            child: const Icon(Icons.phone, size: 24.0)),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin),
                            child: PersoTextField(
                              title: AppLocalizations.of(context)!.phone_number,
                              customValidator:
                                  TextFieldValidator.validateDigits,
                              textInputType: TextInputType.phone,
                              textEditingController: _phoneNumberController,
                            ),
                          ),
                        ),
                      ],
                    )),
                Visibility(
                  visible: widget._userType == UserType.trainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: const PersoDivider()),
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: Dimens.normalMargin),
                                  child: const Icon(Icons.text_snippet,
                                      size: 24.0)),
                              Expanded(
                                child: Container(
                                  height: 140.0,
                                  margin: const EdgeInsets.only(
                                      left: Dimens.normalMargin),
                                  child: PersoTextField(
                                    title: AppLocalizations.of(context)!.short_bio,
                                    customValidator:
                                        TextFieldValidator.validateIsEmpty,
                                    isMultiLine: true,
                                    maxLength: 150,
                                    textEditingController: _shortBioController,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 340.0,
                          margin: const EdgeInsets.only(
                              left: Dimens.substantialMargin,
                              top: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: PersoTextField(
                            title: AppLocalizations.of(context)!.long_bio,
                            isMultiLine: true,
                            maxLength: 500,
                            customValidator: TextFieldValidator.validateIsEmpty,
                            textEditingController: _fullBioController,
                          )),
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: const PersoDivider()),
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              left: Dimens.normalMargin),
                          child: Text(
                            AppLocalizations.of(context)!.select_your_specialities,
                            style: ThemeText.bodyBoldBlackText,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: Dimens.smallMargin),
                        child: _persoChipsList,
                      ),
                    ],
                  ),
                ),
                Center(
                    child: Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.biggerMargin,
                      bottom: Dimens.biggerMargin,
                      right: Dimens.normalMargin),
                  child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
                    builder: (context, state) {
                      return state.whenOrNull(
                            loading: () => Center(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: Dimens.normalMargin),
                                    child: const CircularProgressIndicator())),
                          ) ??
                          PersoButton(
                              width: 160.0, title: AppLocalizations.of(context)!.next, onTap: _uploadData);
                    },
                    listener: (context, state) {
                      state.whenOrNull(
                          success: () => context.replaceNamed(
                              ScreenNavigationKey.profileCreationSuccess));
                    },
                  ),
                )),
                Center(
                    child: Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.normalMargin,
                  ),
                  child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
                    builder: (context, state) {
                      return state.whenOrNull(
                              error: (error) => Text(
                                  "Something went wrong - $error",
                                  style: ThemeText.calloutRegularRed)) ??
                          Container();
                    },
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _uploadData(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      String location = _addressWidget.autocompleteController?.text ?? "";
      if (widget._userType == UserType.trainer) {
        _addTrainerData(location, context);
      } else {
        _addClientData(location, context);
      }
    }
  }

  void _addClientData(String location, BuildContext context) {
    final clientData = ClientData(
        imagePath: _image?.path,
        name: _nameController.text,
        surname: _surnameController.text,
        nickname: _nicknameController.text,
        location: location,
        phoneNumber: _phoneNumberController.text);

    context
        .read<ProfileEditBloc>()
        .add(ProfileEditEvent.uploadClientData(clientData));
  }

  void _addTrainerData(String location, BuildContext context) {
    List<String> languages = _spokenLanguageRowWidget.listOfLanguages
        .map((element) => element.keys)
        .expand((element) => element)
        .toList();

    final trainerData = TrainerData(
        imagePath: _image?.path,
        languages: languages,
        name: _nameController.text,
        surname: _surnameController.text,
        nickname: _nicknameController.text,
        location: location,
        phoneNumber: _phoneNumberController.text,
        shortBio: _shortBioController.text,
        fullBio: _fullBioController.text,
        categories: _persoChipsList.categories);

    context
        .read<ProfileEditBloc>()
        .add(ProfileEditEvent.uploadTrainerData(trainerData));
  }
}
