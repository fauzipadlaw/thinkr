import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thinkr/core/localization/app_locale.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({@Default(AppLocale.en) AppLocale locale}) =
      _SettingsState;

  static const SettingsState initial = SettingsState();
}
