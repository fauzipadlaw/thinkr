// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:thinkr/features/auth/data/auth_repository_dummy.dart' as _i167;
import 'package:thinkr/features/auth/domain/auth_repository.dart' as _i806;
import 'package:thinkr/features/auth/presentation/auth_cubit.dart' as _i927;
import 'package:thinkr/features/settings/presentation/settings_cubit.dart'
    as _i237;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i237.SettingsCubit>(() => _i237.SettingsCubit());
  gh.lazySingleton<_i806.AuthRepository>(() => _i167.DummyAuthRepository());
  gh.lazySingleton<_i927.AuthCubit>(
    () => _i927.AuthCubit(gh<_i806.AuthRepository>()),
  );
  return getIt;
}
