import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionProviderCubit extends Cubit<String> {
  VersionProviderCubit() : super('');

  Future<void> fetchVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(packageInfo.version);
  }
}
