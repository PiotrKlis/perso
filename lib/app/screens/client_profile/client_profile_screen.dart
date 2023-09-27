import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/data/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientProfileScreen extends StatelessWidget {
  ClientProfileScreen({super.key});
  final AuthService _authService = getIt.get<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PersoAppBar(title: "Profile screen"),
        body: PersoButton(
          title: 'Logout',
          onTap: (context) async {
            //TODO: Move into bloc layer while working on the screen
            await _authService.logout();
            context.replaceNamed(ScreenNavigationKey.home);
          },
        ));
  }
}
