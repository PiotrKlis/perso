import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/app/screens/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:Perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:Perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/perso_autocomplete.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:Perso/core/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key, required UserType userType})
      : _userType = userType;

  final UserType _userType;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _shortBioController = TextEditingController();
  final _longBioController = TextEditingController();
  final _spokenLanguageRowWidget = SpokenLanguageRowWidget();

  @override
  Widget build(BuildContext context) {
    _addNicknameListener();
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
                    margin: const EdgeInsets.only(top: Dimens.bigMargin),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: Image.asset("assets/images/trainer3.png"),
                      //Image(image: AssetImage("assets/images/screenshot.png")
                    ),
                  ),
                ),
                //TODO: Add image upload functionality
                // https://pub.dev/packages/image_picker
                Container(
                    margin: EdgeInsets.only(top: Dimens.bigMargin),
                    child: const Center(
                        child: PersoButton(title: "Upload image"))),
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
                                title: "Name",
                                nameController: _nameController,
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
                      surnameController: _surnameController,
                      title: "Surname",
                      customValidator: TextFieldValidator.validateIsEmpty),
                ),
                Container(
                    margin: const EdgeInsets.only(
                        left: Dimens.substantialMargin,
                        top: Dimens.bigMargin,
                        right: Dimens.normalMargin),
                    child: PersoTextField(
                        title: "Nickname",
                        genericController: _nicknameController,
                        customValidator: TextFieldValidator.validateNickname)),
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
                              child: PersoAutocomplete(
                                controller: _locationController,
                              )),
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
                              title: "Phone number",
                              customValidator:
                                  TextFieldValidator.validateDigits,
                              textInputType: TextInputType.phone,
                              genericController: _phoneNumberController,
                            ),
                          ),
                        ),
                      ],
                    )),
                Visibility(
                  visible: widget._userType == UserType.trainer,
                  child: Column(
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
                                    title: "Short Bio",
                                    customValidator:
                                        TextFieldValidator.validateIsEmpty,
                                    isMultiLine: true,
                                    maxLength: 150,
                                    genericController: _shortBioController,
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
                            title: "Long bio",
                            isMultiLine: true,
                            maxLength: 500,
                            customValidator: TextFieldValidator.validateIsEmpty,
                            genericController: _longBioController,
                          )),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: Dimens.biggerMargin,
                          bottom: Dimens.biggerMargin,
                          right: Dimens.normalMargin),
                      child: PersoButton(
                          width: 160.0, title: "Next", onTap: _uploadData)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _uploadData(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      List<String> languages = _spokenLanguageRowWidget.listOfLanguages
          .map((element) => element.keys)
          .expand((element) => element)
          .toList();

      final trainerData = TrainerData(
          "image",
          languages,
          _nameController.text,
          _surnameController.text,
          _nicknameController.text,
          _locationController.text,
          _phoneNumberController.text,
          _shortBioController.text,
          _longBioController.text);
      context.read<ProfileEditBloc>().add(ProfileEditEvent.uploadTrainerData(trainerData));
    }
  }

  void _addNicknameListener() {
    _nameController.addListener(() {
      setState(() {
        _nicknameController.text =
            _nameController.text + _surnameController.text.toUpperCase();
      });
    });
    _surnameController.addListener(() {
      setState(() {
        _nicknameController.text =
            _nameController.text + _surnameController.text.toUpperCase();
      });
    });
  }
}
