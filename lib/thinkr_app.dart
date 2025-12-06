import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/localization/app_locale.dart';
import 'package:thinkr/features/splash/presentation/splash_page.dart';

import 'features/settings/presentation/settings_cubit.dart';
import 'features/settings/presentation/settings_state.dart';
import 'l10n/app_localizations.dart';

class ThinkrApp extends StatelessWidget {
  final GoRouter router;

  const ThinkrApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return MaterialApp.router(
          title: 'Thinkr',
          routerConfig: router,
          locale: settingsState.locale.toLocale,
          supportedLocales: const [Locale('en'), Locale('id')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return SplashWrapper(child: child);
          },
        );
      },
    );
  }
}
