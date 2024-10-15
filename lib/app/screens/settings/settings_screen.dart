import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/providers/permission_provider_cubit.dart';
import 'package:perso/core/providers/version_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VersionProviderCubit>(
          create: (context) => VersionProviderCubit()..fetchVersion(),
        ),
        BlocProvider<PermissionProviderCubit>(
          create: (context) =>
              PermissionProviderCubit()..checkLocationPermissionStatus(),
        ),
      ],
      child: Scaffold(
        appBar: PersoAppBar(
          title: context.strings.settings,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'App version',
                style: ThemeText.mediumTitleBold,
              ),
              BlocBuilder<VersionProviderCubit, String>(
                builder: (context, version) {
                  return Container(
                    margin: const EdgeInsets.only(top: Dimens.sMargin),
                    child: Text(version),
                  );
                },
              ),
              const Text(
                'Localization permission',
                style: ThemeText.mediumTitleBold,
              ),
              BlocBuilder<PermissionProviderCubit, PermissionStatus>(
                builder: (context, permissionStatus) {
                  final switchValue =
                      permissionStatus == PermissionStatus.granted;
                  return Switch(
                    value: switchValue,
                    onChanged: (value) {
                      if (permissionStatus ==
                              PermissionStatus.permanentlyDenied ||
                          permissionStatus == PermissionStatus.granted) {
                        openAppSettings();
                      } else {
                        Permission.notification.request();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
