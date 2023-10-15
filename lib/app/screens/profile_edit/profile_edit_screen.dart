import 'dart:async';
import 'dart:io';

import 'package:Perso/app/models/editable_client_data.dart';
import 'package:Perso/app/models/editable_trainer_data.dart';
import 'package:Perso/app/screens/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:Perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:Perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/adress_and_map/bloc/addres_and_map_bloc.dart';
import 'package:Perso/app/widgets/adress_and_map/google_map.dart';
import 'package:Perso/app/widgets/adress_and_map/perso_autocomplete.dart';
import 'package:Perso/app/widgets/adress_and_map/state/address_and_map_state.dart';
import 'package:Perso/app/widgets/category_chips/category_chips.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_async_text_field.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_indented_divider.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key, required UserType userType})
      : _userType = userType;

  final UserType _userType;
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController autoCompleteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final shortBioController = TextEditingController();
  final fullBioController = TextEditingController();
  final spokenLanguageRowWidget = SpokenLanguageRowWidget();
  final persoChipsList = PersoCategoryChips();
  final picker = ImagePicker();
  PersoGoogleMap googleMap = PersoGoogleMap();
  final PersoAutocomplete addressWidget = PersoAutocomplete();
  XFile? image;
  LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    var imageSection = Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration:
        const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        margin: const EdgeInsets.only(top: Dimens.bigMargin),
        child: image == null
            ? const Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 120.0,
        )
            : ClipOval(
          child: Image.file(
            File(image!.path),
            width: 200.0,
            height: 200.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    var uploadImageButton = Container(
        margin: const EdgeInsets.only(top: Dimens.bigMargin),
        child: Center(
            child: PersoButton(
              title: AppLocalizations.of(context)!.upload_image,
              onTap: (context) {
                getImage();
              },
            )));
    var languageSection = Visibility(
      visible: widget._userType == UserType.trainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin, right: Dimens.normalMargin),
              child: const PersoIndentedDivider()),
          Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              child: spokenLanguageRowWidget),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.normalMargin, right: Dimens.bigMargin),
              child: const PersoIndentedDivider()),
        ],
      ),
    );
    var surname = Container(
      margin: const EdgeInsets.only(
          left: Dimens.substantialMargin,
          top: Dimens.bigMargin,
          right: Dimens.normalMargin),
      child: PersoTextField(
          textEditingController: surnameController,
          title: AppLocalizations.of(context)!.surname,
          customValidator: TextFieldValidator.validateIsEmpty),
    );
    var nickname = Container(
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
          controller: nicknameController),
    );
    var location = Container(
        margin: const EdgeInsets.only(
            top: Dimens.normalMargin, right: Dimens.normalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: Dimens.normalMargin),
                child: const Icon(Icons.pin_drop, size: 24.0)),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: Dimens.normalMargin),
                  child: addressWidget),
            ),
          ],
        ));
    var shortBio = Container(
        margin: const EdgeInsets.only(
            top: Dimens.normalMargin, right: Dimens.normalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: Dimens.normalMargin),
                child: const Icon(Icons.text_snippet, size: 24.0)),
            Expanded(
              child: Container(
                height: 140.0,
                margin: const EdgeInsets.only(left: Dimens.normalMargin),
                child: PersoTextField(
                  title: AppLocalizations.of(context)!.short_bio,
                  customValidator: TextFieldValidator.validateIsEmpty,
                  isMultiLine: true,
                  maxLength: 150,
                  textEditingController: shortBioController,
                ),
              ),
            ),
          ],
        ));
    var longBio = Container(
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
          textEditingController: fullBioController,
        ));
    var bioAndSpecialitiesSection = Visibility(
      visible: widget._userType == UserType.trainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.normalMargin, right: Dimens.normalMargin),
              child: const PersoIndentedDivider()),
          shortBio,
          longBio,
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.normalMargin, right: Dimens.normalMargin),
              child: const PersoIndentedDivider()),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.normalMargin, left: Dimens.normalMargin),
              child: Text(
                AppLocalizations.of(context)!.select_your_specialities,
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(top: Dimens.smallMargin),
            child: persoChipsList,
          ),
        ],
      ),
    );
    var sendDataButton = Center(
        child: Container(
          margin: const EdgeInsets.only(
              top: Dimens.biggerMargin,
              bottom: Dimens.biggerMargin,
              right: Dimens.normalMargin),
          child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
            builder: (context, state) {
              return state.whenOrNull(
                loading: () =>
                    Center(
                        child: Container(
                            margin:
                            const EdgeInsets.only(bottom: Dimens.normalMargin),
                            child: const CircularProgressIndicator())),
              ) ??
                  PersoButton(
                      width: 160.0,
                      title: AppLocalizations.of(context)!.next,
                      onTap: uploadData);
            },
            listener: (context, state) {
              state.whenOrNull(
                  success: () =>
                      context
                          .replaceNamed(
                          ScreenNavigationKey.profileCreationSuccess));
            },
          ),
        ));
    var sendDataErrorText = Center(
        child: Container(
          margin: const EdgeInsets.only(
            top: Dimens.normalMargin,
          ),
          child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
            builder: (context, state) {
              return state.whenOrNull(
                  error: (error) =>
                      Text("Something went wrong - $error",
                          style: ThemeText.calloutRegularRed)) ??
                  Container();
            },
          ),
        ));

    var nameSection = Container(
        margin: const EdgeInsets.only(top: Dimens.normalMargin),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: Dimens.normalMargin),
                child: const Icon(Icons.person, size: 24.0)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: Dimens.normalMargin, right: Dimens.normalMargin),
                child: PersoTextField(
                    title: AppLocalizations.of(context)!.name,
                    textEditingController: nameController,
                    customValidator: TextFieldValidator.validateIsEmpty),
              ),
            ),
          ],
        ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileEditBloc()),
        BlocProvider(create: (context) => AddressAndMapBloc()),
      ],
      child: BlocBuilder<AddressAndMapBloc, AddressAndMapState>(
          builder: (context, state) {
            state.whenOrNull(mapUpdate: (latLon) {
              latLng = latLon;
            },
            );
            return Scaffold(
              backgroundColor: PersoColors.lightBlue,
              appBar: PersoAppBar(
                  title: AppLocalizations.of(context)!
                      .edit_profile(widget._userType.toString())),
              body: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageSection,
                      uploadImageButton,
                      languageSection,
                      nameSection,
                      surname,
                      nickname,
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: const PersoIndentedDivider()),
                      location,
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin),
                          child: googleMap),
                      bioAndSpecialitiesSection,
                      sendDataButton,
                      sendDataErrorText
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Future<void> getImage() async {
    final XFile? pickedImage =
    await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  void addTrainerData(BuildContext context) {
    List<String> languages = spokenLanguageRowWidget.listOfLanguages
        .map((element) => element.keys)
        .expand((element) => element)
        .toList();
    String location = addressWidget.autocompleteController?.text ?? "";

    final trainerData = EditableTrainerData(
        imagePath: image?.path ?? "",
        languages: languages,
        name: nameController.text,
        surname: surnameController.text,
        nickname: nicknameController.text,
        location: location,
        phoneNumber: phoneNumberController.text,
        shortBio: shortBioController.text,
        fullBio: fullBioController.text,
        categories: persoChipsList.selectedCategories,
        latLng: latLng ?? const LatLng(0.0, 0.0));

        context
        .read<ProfileEditBloc>()
        .add(ProfileEditEvent.uploadTrainerData(trainerData));
  }

  void addClientData(BuildContext context) {
    String location = addressWidget.autocompleteController?.text ?? "";

    final clientData = EditableClientData(
        imagePath: image?.path ?? "",
        name: nameController.text,
        surname: surnameController.text,
        nickname: nicknameController.text,
        location: location);

    context
        .read<ProfileEditBloc>()
        .add(ProfileEditEvent.uploadClientData(clientData));
  }

  void uploadData(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      if (widget._userType == UserType.trainer) {
        addTrainerData(context);
      } else {
        addClientData(context);
      }
    }
  }

  Container nameSection(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: Dimens.normalMargin),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: Dimens.normalMargin),
                child: const Icon(Icons.person, size: 24.0)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: Dimens.normalMargin, right: Dimens.normalMargin),
                child: PersoTextField(
                    title: AppLocalizations.of(context)!.name,
                    textEditingController: nameController,
                    customValidator: TextFieldValidator.validateIsEmpty),
              ),
            ),
          ],
        ));
  }
}
