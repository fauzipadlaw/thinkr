import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/localization/app_locale.dart';
import 'settings_state.dart';

@lazySingleton
abstract class SettingsCubit extends StateStreamableSource<SettingsState> {
  @factoryMethod
  factory SettingsCubit() = _SettingsCubitImpl;

  void initialize();
  void changeLanguage(AppLocale locale);
}

class _SettingsCubitImpl extends Cubit<SettingsState> implements SettingsCubit {
  _SettingsCubitImpl() : super(SettingsState.initial);

  @override
  void initialize() {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final appLocale = AppLocaleX.fromDevice(deviceLocale);
    emit(state.copyWith(locale: appLocale));
  }

  @override
  void changeLanguage(AppLocale locale) {
    emit(state.copyWith(locale: locale));
  }
}
