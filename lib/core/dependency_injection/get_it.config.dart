// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:perso/data/address_provider/google_address_provider.dart'
    as _i9;
import 'package:perso/data/auth/auth_service.dart' as _i3;
import 'package:perso/data/clients/clients_provider/firestore_clients_provider.dart'
    as _i4;
import 'package:perso/data/clients/clients_service/firestore_clients_service.dart'
    as _i5;
import 'package:perso/data/exercise_provider/firestore_exercise_provider.dart'
    as _i6;
import 'package:perso/data/shared_prefs/perso_shared_prefs.dart' as _i12;
import 'package:perso/data/trainer_search_cards/local_trainer_search_card_repository.dart'
    as _i10;
import 'package:perso/data/trainers/trainers_provider/firestore_trainers_provider.dart'
    as _i7;
import 'package:perso/data/trainers/trainers_provider/test_trainers_repository.dart'
    as _i13;
import 'package:perso/data/trainers/trainers_service/firestore_trainers_service.dart'
    as _i8;
import 'package:perso/data/training_categories/local_training_category_repository.dart'
    as _i11;
import 'package:perso/data/training_request/training_request_service.dart'
    as _i14;
import 'package:perso/data/user_info/user_info_provider.dart' as _i15;

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
    gh.factory<_i4.FirestoreClientsProvider>(
        () => _i4.FirestoreClientsProvider());
    gh.factory<_i5.FirestoreClientsService>(
        () => _i5.FirestoreClientsService());
    gh.factory<_i6.FirestoreExerciseProvider>(
        () => _i6.FirestoreExerciseProvider());
    gh.factory<_i7.FirestoreTrainersProvider>(
        () => _i7.FirestoreTrainersProvider());
    gh.factory<_i8.FirestoreTrainersService>(
        () => _i8.FirestoreTrainersService());
    gh.singleton<_i9.GoogleAddressProvider>(_i9.GoogleAddressProvider());
    gh.factory<_i10.LocalTrainerSearchCardRepository>(
        () => _i10.LocalTrainerSearchCardRepository());
    gh.factory<_i11.LocalTrainingCategoryRepository>(
        () => _i11.LocalTrainingCategoryRepository());
    gh.singleton<_i12.PersoSharedPrefs>(_i12.PersoSharedPrefs());
    gh.factory<_i13.TestTrainersRepository>(
        () => _i13.TestTrainersRepository());
    gh.factory<_i14.TrainingRequestService>(
        () => _i14.TrainingRequestService());
    gh.singleton<_i15.UserInfoProvider>(_i15.UserInfoProvider());
    return this;
  }
}
