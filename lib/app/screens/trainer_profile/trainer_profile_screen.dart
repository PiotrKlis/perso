import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/data/auth/auth_service.dart';

class TrainerProfileScreen extends StatelessWidget {
  TrainerProfileScreen({super.key});

  final AuthService _authService = getIt.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(title: "Trainer profile screen"),
      body: PersoButton(
        title: context.strings.logout,
        onTap: (context) async {
          //TODO: Move into bloc layer while working on the screen
          await _authService.logout();
          context.replaceNamed(ScreenNavigationKey.home);
        },
      ),
    );
  }
}
