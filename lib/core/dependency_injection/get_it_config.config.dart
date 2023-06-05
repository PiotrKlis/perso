// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:Perso/data/address_provider/google_address_provider.dart'
    as _i4;
import 'package:Perso/data/trainer_search_cards/local_trainer_search_card_repository.dart'
    as _i5;
import 'package:Perso/data/trainers/firestore_trainers_provider.dart' as _i3;
import 'package:Perso/data/trainers/test_trainers_repository.dart' as _i7;
import 'package:Perso/data/training_categories/local_training_category_repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
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
    gh.factory<_i3.FirestoreTrainersProvider>(
        () => _i3.FirestoreTrainersProvider());
    gh.factory<_i4.GoogleAddressProvider>(() => _i4.GoogleAddressProvider());
    gh.factory<_i5.LocalTrainerSearchCardRepository>(
        () => _i5.LocalTrainerSearchCardRepository());
    gh.factory<_i6.LocalTrainingCategoryRepository>(
        () => _i6.LocalTrainingCategoryRepository());
    gh.factory<_i7.TestTrainersRepository>(() => _i7.TestTrainersRepository());
    return this;
  }
}
