import 'package:Perso/app/utils/localisation_keys.dart';
import 'package:Perso/core/navigation/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          buttonTheme: const ButtonThemeData(
              buttonColor: Colors.black, textTheme: ButtonTextTheme.primary),
          fontFamily: "Inter"),
      child: PlatformProvider(
        builder: (context) => PlatformApp.router(
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
