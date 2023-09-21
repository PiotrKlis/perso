import 'package:Perso/app/utils/localisation_keys.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/navigation/navigation_config.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies("debug");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();
  final PersoSharedPrefs _persoSharedPrefs = getIt.get<PersoSharedPrefs>();

  @override
  Widget build(BuildContext context) {
    _userInfoProvider.listenForFirebaseUserChange();
    _persoSharedPrefs.init();

    return Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          buttonTheme: const ButtonThemeData(
              buttonColor: Colors.black, textTheme: ButtonTextTheme.primary),
          fontFamily: "Inter"),
      child: PlatformProvider(
        builder: (context) => MaterialApp.router(
          routerConfig: goRouter,
          title: "Perso",
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(LocalisationKeys.englishLocaleKey),
            Locale(LocalisationKeys.polishLocaleKey),
          ],
        ),
      ),
    );
  }
}
