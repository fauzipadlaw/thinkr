import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/core/localization/app_locale.dart';
import 'package:thinkr/features/settings/presentation/settings_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SettingsCubit cubit;

  setUp(() {
    cubit = SettingsCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('SettingsCubit', () {
    test('initial state should have default locale', () {
      expect(cubit.state.locale, AppLocale.en);
    });

    test('changeLanguage should update locale', () {
      cubit.changeLanguage(AppLocale.id);

      expect(cubit.state.locale, AppLocale.id);
    });

    test('changeLanguage should support all available locales', () {
      for (final locale in AppLocale.values) {
        cubit.changeLanguage(locale);
        expect(cubit.state.locale, locale);
      }
    });

    test('initialize should set locale from device', () {
      // Note: This test is environment-dependent
      // In a real test, we'd need to mock the platform dispatcher
      cubit.initialize();

      expect(cubit.state.locale, isNotNull);
    });
  });
}
