// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:thinkr/core/di/supabase_module.dart' as _i21;
import 'package:thinkr/core/env/environment.dart' as _i480;
import 'package:thinkr/features/auth/data/auth_repository.dart' as _i262;
import 'package:thinkr/features/auth/domain/auth_repository.dart' as _i806;
import 'package:thinkr/features/auth/presentation/auth_cubit.dart' as _i927;
import 'package:thinkr/features/auth/presentation/auth_state_notifier.dart'
    as _i131;
import 'package:thinkr/features/decision/data/decision_repository_supabase.dart'
    as _i373;
import 'package:thinkr/features/decision/domain/decision_repository.dart'
    as _i733;
import 'package:thinkr/features/decision/domain/usecases/evaluate_decision_usecase.dart'
    as _i329;
import 'package:thinkr/features/decision/domain/usecases/save_decision_usecase.dart'
    as _i501;
import 'package:thinkr/features/decision/domain/usecases/soft_delete_decision_usecase.dart'
    as _i862;
import 'package:thinkr/features/decision/presentation/decision_editor_cubit.dart'
    as _i304;
import 'package:thinkr/features/settings/presentation/settings_cubit.dart'
    as _i237;
import 'package:thinkr/thinkr_router.dart' as _i865;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final supabaseModule = _$SupabaseModule();
  final routerModule = _$RouterModule();
  gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient());
  gh.lazySingleton<_i329.EvaluateDecisionUseCase>(
    () => const _i329.EvaluateDecisionUseCase(),
  );
  gh.lazySingleton<_i237.SettingsCubit>(() => _i237.SettingsCubit());
  gh.lazySingleton<_i806.AuthRepository>(
    () => _i262.SupabaseAuthRepository(
      gh<_i454.SupabaseClient>(),
      gh<_i480.EnvConfig>(),
    ),
  );
  gh.lazySingleton<_i927.AuthCubit>(
    () => _i927.AuthCubit(gh<_i806.AuthRepository>()),
  );
  gh.lazySingleton<_i131.AuthStateNotifier>(
    () => _i131.AuthStateNotifier(gh<_i806.AuthRepository>()),
  );
  gh.lazySingleton<_i733.DecisionRepository>(
    () => _i373.SupabaseDecisionRepository(
      gh<_i454.SupabaseClient>(),
      gh<_i806.AuthRepository>(),
    ),
  );
  gh.lazySingleton<_i583.GoRouter>(
    () => routerModule.router(gh<_i131.AuthStateNotifier>()),
  );
  gh.lazySingleton<_i501.SaveDecisionUseCase>(
    () => _i501.SaveDecisionUseCase(gh<_i733.DecisionRepository>()),
  );
  gh.lazySingleton<_i862.SoftDeleteDecisionUseCase>(
    () => _i862.SoftDeleteDecisionUseCase(gh<_i733.DecisionRepository>()),
  );
  gh.lazySingleton<_i304.DecisionEditorCubit>(
    () => _i304.DecisionEditorCubit(
      gh<_i329.EvaluateDecisionUseCase>(),
      gh<_i501.SaveDecisionUseCase>(),
    ),
  );
  return getIt;
}

class _$SupabaseModule extends _i21.SupabaseModule {}

class _$RouterModule extends _i865.RouterModule {}
