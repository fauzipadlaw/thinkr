// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Thinkr';

  @override
  String get home_title => 'What do you want to decide today?';

  @override
  String get home_newDecision => 'New decision';

  @override
  String get home_history => 'History';

  @override
  String get login_signIn => 'Sign in';

  @override
  String get login_signOut => 'Sign out';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_language_english => 'English';

  @override
  String get settings_language_indonesian => 'Indonesian';

  @override
  String get login_title => 'Login';

  @override
  String get login_welcome => 'Welcome to Thinkr';

  @override
  String get login_signInWithGoogle => 'Sign in with Google';
}
