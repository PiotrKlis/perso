import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/app/models/editable_trainer_data.dart';
import 'package:perso/app/screens/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/address_and_map/bloc/addres_and_map_bloc.dart';
import 'package:perso/app/widgets/address_and_map/google_map.dart';
import 'package:perso/app/widgets/address_and_map/perso_autocomplete.dart';
import 'package:perso/app/widgets/address_and_map/state/address_and_map_state.dart';
import 'package:perso/app/widgets/category_chips/perso_selectable_category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_async_text_field.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_indented_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/spoken_language_row.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({required UserType userType, super.key})
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
  final persoChipsList = PersoSelectableCategoryChips();
  final googleMap = const PersoGoogleMap();
  final PersoAutocomplete addressWidget = PersoAutocomplete();
  XFile? image;
  LatLng? latLng;
  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileEditBloc()),
        BlocProvider(create: (context) => AddressAndMapBloc()),
      ],
      child: BlocBuilder<AddressAndMapBloc, AddressAndMapState>(
        builder: (context, state) {
          state.whenOrNull(
            mapUpdate: (latLon) {
              latLng = latLon;
            },
          );
          return Scaffold(
            backgroundColor: PersoColors.lightBlue,
            appBar: PersoAppBar(
              title: context.strings.edit_profile(widget._userType.name),
            ),
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        margin: const EdgeInsets.only(top: Dimens.lMargin),
                        child: image == null
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 120,
                              )
                            : ClipOval(
                                child: Image.file(
                                  File(image!.path),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: Dimens.lMargin,
                        left: Dimens.lMargin,
                        right: Dimens.lMargin,
                      ),
                      child: Center(
                        child: PersoButton(
                          title: context.strings.upload_image,
                          onTap: (context) async {
                            final pickedImage = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 640,
                              maxWidth: 640,
                            );
                            setState(() {
                              image = pickedImage;
                            });
                          },
                        ),
                      ),
                    ),
                    _NameSection(nameController: nameController),
                    _SurnameSection(surnameController: surnameController),
                    _NicknameSection(
                      widget: widget,
                      nicknameController: nicknameController,
                    ),
                    const _Divider(),
                    _Languages(
                      spokenLanguageRowWidget: spokenLanguageRowWidget,
                    ),
                    _TrainerOnlySection(
                      widget: widget,
                      addressWidget: addressWidget,
                      googleMap: googleMap,
                      shortBioController: shortBioController,
                      fullBioController: fullBioController,
                      persoChipsList: persoChipsList,
                    ),
                    _ConfirmButton(
                      formKey: formKey,
                      widget: widget,
                      spokenLanguageRowWidget: spokenLanguageRowWidget,
                      image: image,
                      nameController: nameController,
                      surnameController: surnameController,
                      nicknameController: nicknameController,
                      addressWidget: addressWidget,
                      phoneNumberController: phoneNumberController,
                      shortBioController: shortBioController,
                      fullBioController: fullBioController,
                      persoChipsList: persoChipsList,
                      latLng: latLng,
                    ),
                    const _ErrorText(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    required this.formKey,
    required this.widget,
    required this.spokenLanguageRowWidget,
    required this.image,
    required this.nameController,
    required this.surnameController,
    required this.nicknameController,
    required this.addressWidget,
    required this.phoneNumberController,
    required this.shortBioController,
    required this.fullBioController,
    required this.persoChipsList,
    required this.latLng,
  });

  final GlobalKey<FormState> formKey;
  final ProfileEditScreen widget;
  final SpokenLanguageRowWidget spokenLanguageRowWidget;
  final XFile? image;
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController nicknameController;
  final PersoAutocomplete addressWidget;
  final TextEditingController phoneNumberController;
  final TextEditingController shortBioController;
  final TextEditingController fullBioController;
  final PersoSelectableCategoryChips persoChipsList;
  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: Dimens.xlMargin,
          bottom: Dimens.xlMargin,
          right: Dimens.xmMargin,
          left: Dimens.xmMargin,
        ),
        child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
          builder: (context, state) {
            return state.whenOrNull(
                  loading: () => Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: Dimens.xmMargin,
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ) ??
                PersoButton(
                  title: context.strings.next,
                  onTap: (context) {
                    if (formKey.currentState?.validate() == true) {
                      if (widget._userType == UserType.trainer) {
                        final languages = spokenLanguageRowWidget
                            .listOfLanguages
                            .map((element) => element.keys)
                            .expand((element) => element)
                            .toList();

                        final trainerData = EditableTrainerData(
                          imagePath: image?.path ?? '',
                          languages: languages,
                          name: nameController.text,
                          surname: surnameController.text,
                          nickname: nicknameController.text,
                          location:
                              addressWidget.autocompleteController?.text ?? '',
                          phoneNumber: phoneNumberController.text,
                          shortBio: shortBioController.text,
                          fullBio: fullBioController.text,
                          categories: persoChipsList.selectedCategories,
                          latLng: latLng ?? const LatLng(0, 0),
                        );

                        context.read<ProfileEditBloc>().add(
                              ProfileEditEvent.uploadTrainerData(
                                trainerData,
                              ),
                            );
                      } else {
                        final languages = spokenLanguageRowWidget
                            .listOfLanguages
                            .map((element) => element.keys)
                            .expand((element) => element)
                            .toList();

                        final clientData = EditableClientData(
                          imagePath: image?.path ?? '',
                          name: nameController.text,
                          surname: surnameController.text,
                          nickname: nicknameController.text,
                          languages: languages,
                        );

                        context.read<ProfileEditBloc>().add(
                              ProfileEditEvent.uploadClientData(
                                clientData,
                              ),
                            );
                      }
                    }
                  },
                );
          },
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
        ),
      ),
    );
  }
}

class _Languages extends StatelessWidget {
  const _Languages({
    required this.spokenLanguageRowWidget,
  });

  final SpokenLanguageRowWidget spokenLanguageRowWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.xmMargin),
      child: spokenLanguageRowWidget,
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

class _NicknameSection extends StatelessWidget {
  const _NicknameSection({
    required this.widget,
    required this.nicknameController,
  });

  final ProfileEditScreen widget;
  final TextEditingController nicknameController;

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
        hintText: context.strings.nickname,
        validator: widget._userInfoProvider.isNicknameUnique,
        validationDebounce: const Duration(milliseconds: 500),
        controller: nicknameController,
      ),
    );
  }
}

class _SurnameSection extends StatelessWidget {
  const _SurnameSection({
    required this.surnameController,
  });

  final TextEditingController surnameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xxxlMargin,
        top: Dimens.lMargin,
        right: Dimens.xmMargin,
      ),
      child: PersoTextField(
        textEditingController: surnameController,
        hintText: context.strings.surname,
        customValidator: TextFieldValidator.validateIsEmpty,
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
  const _NameSection({
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.xmMargin),
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

class _TrainerOnlySection extends StatelessWidget {
  const _TrainerOnlySection({
    required this.widget,
    required this.addressWidget,
    required this.googleMap,
    required this.shortBioController,
    required this.fullBioController,
    required this.persoChipsList,
  });

  final ProfileEditScreen widget;
  final PersoAutocomplete addressWidget;
  final PersoGoogleMap googleMap;
  final TextEditingController shortBioController;
  final TextEditingController fullBioController;
  final PersoSelectableCategoryChips persoChipsList;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget._userType == UserType.trainer,
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
                    child: addressWidget,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.xmMargin),
            child: googleMap,
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
                      textEditingController: shortBioController,
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
              textEditingController: fullBioController,
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
            child: persoChipsList,
          ),
        ],
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: Dimens.xmMargin,
        ),
        child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
          builder: (context, state) {
            return state.whenOrNull(
                  error: (error) => Text(
                    'Something went wrong - $error',
                    style: ThemeText.calloutRegularRed,
                  ),
                ) ??
                Container();
          },
        ),
      ),
    );
  }
}
