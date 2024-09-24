import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.config.dart';
import 'package:perso/core/providers/string_provider.dart';

final getIt = GetIt.instance;

@InjectableInit()
void initializeDependencyInjection(String environment) {
  getIt.init(environment: environment);
}

void setupStringProvider(BuildContext context) {
  if (!getIt.isRegistered<StringProvider>()) {
    getIt.registerSingleton<StringProvider>(StringProvider(context));
  }
}
