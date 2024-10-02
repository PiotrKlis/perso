import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/address/address_cubit.dart';
import 'package:perso/core/models/trainer_entity.dart';

class PersoAddress extends StatefulWidget {
  const PersoAddress({super.key});

  @override
  State<PersoAddress> createState() => _PersoAddressState();
}

class _PersoAddressState extends State<PersoAddress> {
  TextEditingController? autocompleteController;
  TextEditingValue initialValue = TextEditingValue.empty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        state.whenOrNull(
          preFillData: (profileEntity) {
            final trainerEntity = profileEntity as TrainerEntity;
            autocompleteController?.text = trainerEntity.address;
          },
        );
        return Autocomplete<String>(
          initialValue: initialValue,
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            autocompleteController = controller;
            return TextFormField(
              controller: autocompleteController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                errorMaxLines: 2,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.5, color: PersoColors.lightGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.5, color: PersoColors.lightGrey),
                ),
                labelText: 'Address',
                labelStyle: ThemeText.bodyRegularGreyText,
              ),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            final input = textEditingValue.text;
            if (input.isEmpty) {
              return const [];
            } else {
              context.read<AddressCubit>().fetchAddressSuggestions(input);
              return context.watch<AddressCubit>().state;
            }
          },
          onSelected: (String address) {
            autocompleteController?.text = address;
          },
        );
      },
    );
  }
}
