import 'package:Perso/app/util/localisation_keys.dart';
import 'package:Perso/core/navigation/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Perso',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(LocalisationKeys.englishLocaleKey),
        Locale(LocalisationKeys.polishLocaleKey),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
