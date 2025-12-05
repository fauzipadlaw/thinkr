import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/env/environment.dart';
import 'features/auth/presentation/auth_cubit.dart';
import 'features/settings/presentation/settings_cubit.dart';
import 'sl_initializer.dart';
import 'thinkr_app.dart';

final getIt = GetIt.instance;

Future<void> bootstrap(AppEnvironment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // for web

  await SLInitializer.init(getIt);

  final envConfig = EnvConfig.fromDotEnv(env);

  await Supabase.initialize(
    url: envConfig.supabaseUrl,
    anonKey: envConfig.supabaseAnonKey,
  );

  if (!getIt.isRegistered<EnvConfig>()) {
    getIt.registerSingleton<EnvConfig>(EnvConfig.fromDotEnv(env));
  }

  final router = getIt<GoRouter>();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) {
            final cubit = getIt<SettingsCubit>();
            cubit.initialize();
            return cubit;
          },
        ),
        BlocProvider<AuthCubit>(
          create: (_) {
            final cubit = getIt<AuthCubit>();
            cubit.initialize();
            return cubit;
          },
        ),
      ],
      child: ThinkrApp(router: router),
    ),
  );
}
