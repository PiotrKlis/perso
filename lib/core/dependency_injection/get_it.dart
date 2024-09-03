import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void initializeDependencyInjection(String environment) {
  getIt.init(environment: environment);
}
