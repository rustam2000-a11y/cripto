// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:crypto_assistant/home/data/api/coint_api.dart' as _i997;
import 'package:crypto_assistant/home/data/repository/coint_rpository.dart'
    as _i404;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i997.CoinApI>(() => _i997.CoinApi());
    gh.lazySingleton<_i404.CointRepositoryI>(
      () => _i404.CointRepository(api: gh<_i997.CoinApI>()),
    );
    return this;
  }
}
