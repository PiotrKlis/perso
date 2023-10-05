// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:Perso/data/address_provider/google_address_provider.dart'
    as _i7;
import 'package:Perso/data/auth/auth_service.dart' as _i3;
import 'package:Perso/data/clients/firestore_clients_service.dart' as _i4;
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart' as _i10;
import 'package:Perso/data/trainer_search_cards/local_trainer_search_card_repository.dart'
    as _i8;
import 'package:Perso/data/trainers/firestore_trainers_provider.dart' as _i5;
import 'package:Perso/data/trainers/firestore_trainers_service.dart' as _i6;
import 'package:Perso/data/trainers/test_trainers_repository.dart' as _i11;
import 'package:Perso/data/training_categories/local_training_category_repository.dart'
    as _i9;
import 'package:Perso/data/user_info/user_info_provider.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthService>(() => _i3.AuthService());
    gh.factory<_i4.FirestoreClientsService>(
        () => _i4.FirestoreClientsService());
    gh.factory<_i5.FirestoreTrainersProvider>(
        () => _i5.FirestoreTrainersProvider());
    gh.factory<_i6.FirestoreTrainersService>(
        () => _i6.FirestoreTrainersService());
    gh.singleton<_i7.GoogleAddressProvider>(_i7.GoogleAddressProvider());
    gh.factory<_i8.LocalTrainerSearchCardRepository>(
        () => _i8.LocalTrainerSearchCardRepository());
    gh.factory<_i9.LocalTrainingCategoryRepository>(
        () => _i9.LocalTrainingCategoryRepository());
    gh.singleton<_i10.PersoSharedPrefs>(_i10.PersoSharedPrefs());
    gh.factory<_i11.TestTrainersRepository>(
        () => _i11.TestTrainersRepository());
    gh.singleton<_i12.UserInfoProvider>(_i12.UserInfoProvider());
    return this;
  }
}
