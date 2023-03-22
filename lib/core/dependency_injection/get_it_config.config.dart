// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:Perso/data/repositories/trainer_search_cards/local_trainer_search_card_repository.dart'
    as _i4;
import 'package:Perso/data/repositories/trainers/firestore_trainers_repository.dart'
    as _i3;
import 'package:Perso/data/repositories/trainers/test_trainers_repository.dart'
    as _i6;
import 'package:Perso/data/repositories/training_categories/local_training_category_repository.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

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
    gh.factory<_i3.FirestoreTrainersRepository>(
        () => _i3.FirestoreTrainersRepository());
    gh.factory<_i4.LocalTrainerSearchCardRepository>(
        () => _i4.LocalTrainerSearchCardRepository());
    gh.factory<_i5.LocalTrainingCategoryRepository>(
        () => _i5.LocalTrainingCategoryRepository());
    gh.factory<_i6.TestTrainersRepository>(() => _i6.TestTrainersRepository());
    return this;
  }
}
