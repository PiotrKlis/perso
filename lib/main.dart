import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/utils/chat_client.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/utils/locale_repository.dart';
import 'package:perso/app/utils/localisation_keys.dart';
import 'package:perso/app/widgets/internet_connection_service.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/navigation/navigation_config.dart';
import 'package:perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies(Environment.dev);
  LocaleRepository.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();
  final PersoSharedPrefs _persoSharedPrefs = getIt.get<PersoSharedPrefs>();
  final _internetConnectionService = getIt.get<InternetConnectionService>();

  @override
  Widget build(BuildContext context) {
    //TODO: Move these into "build before" component
    _userInfoProvider.listenForFirebaseUserChange();
    _persoSharedPrefs.init();
    _internetConnectionService.init();
    _initializeChat();
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.primary,
        ),
        fontFamily: 'Inter',
      ),
      child: MaterialApp.router(
        routerConfig: goRouter,
        title: 'Perso',
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
    );
  }

  void _initializeChat() {
    if (!_internetConnectionService.connectivityResultController.hasListener) {
      _internetConnectionService.connectivityResultStream.listen((
        connectivityResult,
      ) async {
        if (connectivityResult != ConnectivityResult.none) {
          await ChatClient.initializeClient();
          _internetConnectionService.dispose();
        }
      });
    }
  }
}
