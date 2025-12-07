import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Thinkr'**
  String get appName;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'What do you want to decide today?'**
  String get home_title;

  /// No description provided for @home_newDecision.
  ///
  /// In en, this message translates to:
  /// **'New decision'**
  String get home_newDecision;

  /// No description provided for @home_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get home_history;

  /// No description provided for @home_recentDecisions.
  ///
  /// In en, this message translates to:
  /// **'Recent decisions'**
  String get home_recentDecisions;

  /// No description provided for @home_viewAllHistory.
  ///
  /// In en, this message translates to:
  /// **'See all history'**
  String get home_viewAllHistory;

  /// No description provided for @login_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_signIn;

  /// No description provided for @login_signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get login_signOut;

  /// No description provided for @login_subtitleSignin.
  ///
  /// In en, this message translates to:
  /// **'Welcome back. Sign in to continue.'**
  String get login_subtitleSignin;

  /// No description provided for @login_subtitleSignup.
  ///
  /// In en, this message translates to:
  /// **'Create an account to save your decisions.'**
  String get login_subtitleSignup;

  /// No description provided for @login_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get login_confirmPassword;

  /// No description provided for @login_emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get login_emailRequired;

  /// No description provided for @login_emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get login_emailInvalid;

  /// No description provided for @login_passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get login_passwordRequired;

  /// No description provided for @login_passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get login_passwordTooShort;

  /// No description provided for @login_passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get login_passwordMismatch;

  /// No description provided for @login_signinCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_signinCta;

  /// No description provided for @login_signupCta.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get login_signupCta;

  /// No description provided for @login_needAccount.
  ///
  /// In en, this message translates to:
  /// **'Need an account? Sign up'**
  String get login_needAccount;

  /// No description provided for @login_haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get login_haveAccount;

  /// No description provided for @login_orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get login_orContinueWith;

  /// No description provided for @login_signinSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get login_signinSuccess;

  /// No description provided for @login_signupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created'**
  String get login_signupSuccess;

  /// No description provided for @login_continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get login_continueAsGuest;

  /// No description provided for @login_guestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in as guest'**
  String get login_guestSuccess;

  /// No description provided for @login_captchaRequired.
  ///
  /// In en, this message translates to:
  /// **'Please complete the captcha to continue.'**
  String get login_captchaRequired;

  /// No description provided for @login_errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get login_errorGeneric;

  /// No description provided for @login_discardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get login_discardTitle;

  /// No description provided for @login_discardMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsent input. Leaving will clear the form.'**
  String get login_discardMessage;

  /// No description provided for @login_discardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get login_discardConfirm;

  /// No description provided for @login_discardStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get login_discardStay;

  /// No description provided for @history_title.
  ///
  /// In en, this message translates to:
  /// **'Decision history'**
  String get history_title;

  /// No description provided for @history_emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No decisions yet'**
  String get history_emptyTitle;

  /// No description provided for @history_emptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a decision to see it here.'**
  String get history_emptySubtitle;

  /// No description provided for @history_newDecision.
  ///
  /// In en, this message translates to:
  /// **'New decision'**
  String get history_newDecision;

  /// No description provided for @history_options.
  ///
  /// In en, this message translates to:
  /// **'options'**
  String get history_options;

  /// No description provided for @history_criteria.
  ///
  /// In en, this message translates to:
  /// **'criteria'**
  String get history_criteria;

  /// No description provided for @history_bestOption.
  ///
  /// In en, this message translates to:
  /// **'Best: {option}'**
  String history_bestOption(Object option);

  /// No description provided for @history_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get history_delete;

  /// No description provided for @history_errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load history'**
  String get history_errorTitle;

  /// No description provided for @history_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get history_retry;

  /// No description provided for @decision_editor_stepOptions.
  ///
  /// In en, this message translates to:
  /// **'Add options'**
  String get decision_editor_stepOptions;

  /// No description provided for @decision_editor_stepCriteria.
  ///
  /// In en, this message translates to:
  /// **'Add criteria & weights'**
  String get decision_editor_stepCriteria;

  /// No description provided for @decision_editor_stepScores.
  ///
  /// In en, this message translates to:
  /// **'Score each option'**
  String get decision_editor_stepScores;

  /// No description provided for @decision_editor_stepEvaluate.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get decision_editor_stepEvaluate;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_english;

  /// No description provided for @settings_language_indonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get settings_language_indonesian;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_title;

  /// No description provided for @login_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Thinkr'**
  String get login_welcome;

  /// No description provided for @login_signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get login_signInWithGoogle;

  /// No description provided for @decision_editor_title.
  ///
  /// In en, this message translates to:
  /// **'Decision editor'**
  String get decision_editor_title;

  /// No description provided for @decision_editor_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add options, criteria, weights, and scores to get a ranked recommendation.'**
  String get decision_editor_subtitle;

  /// No description provided for @decision_editor_methodLabel.
  ///
  /// In en, this message translates to:
  /// **'Decision method'**
  String get decision_editor_methodLabel;

  /// No description provided for @decision_editor_methodWeighted.
  ///
  /// In en, this message translates to:
  /// **'Weighted Sum'**
  String get decision_editor_methodWeighted;

  /// No description provided for @decision_editor_methodWeightedDesc.
  ///
  /// In en, this message translates to:
  /// **'Best for quick scoring: uses your weights and 1–10 scores to rank options.'**
  String get decision_editor_methodWeightedDesc;

  /// No description provided for @decision_editor_methodAhp.
  ///
  /// In en, this message translates to:
  /// **'AHP'**
  String get decision_editor_methodAhp;

  /// No description provided for @decision_editor_methodAhpDesc.
  ///
  /// In en, this message translates to:
  /// **'AHP supports pairwise weights; without comparisons we use your weights. Consistency is reported when pairwise data is provided.'**
  String get decision_editor_methodAhpDesc;

  /// No description provided for @decision_editor_methodFuzzy.
  ///
  /// In en, this message translates to:
  /// **'Fuzzy Weighted'**
  String get decision_editor_methodFuzzy;

  /// No description provided for @decision_editor_methodFuzzyDesc.
  ///
  /// In en, this message translates to:
  /// **'Handles uncertainty by spreading each score; still uses your 1–10 inputs and weights.'**
  String get decision_editor_methodFuzzyDesc;

  /// No description provided for @decision_editor_discardMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Leave the editor? Your input will be lost.'**
  String get decision_editor_discardMessage;

  /// No description provided for @decision_editor_discardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave editor'**
  String get decision_editor_discardConfirm;

  /// No description provided for @decision_editor_discardStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get decision_editor_discardStay;

  /// No description provided for @decision_editor_ahpPairwiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Pairwise importance'**
  String get decision_editor_ahpPairwiseTitle;

  /// No description provided for @decision_editor_ahpPairwiseDesc.
  ///
  /// In en, this message translates to:
  /// **'Use the simplified AHP scale to compare each pair of criteria.'**
  String get decision_editor_ahpPairwiseDesc;

  /// No description provided for @decision_editor_ahpScaleLabel.
  ///
  /// In en, this message translates to:
  /// **'AHP 3-point'**
  String get decision_editor_ahpScaleLabel;

  /// No description provided for @decision_editor_ahpScaleNote.
  ///
  /// In en, this message translates to:
  /// **'Equal / Moderate / Strong — pick who is more important in each pair.'**
  String get decision_editor_ahpScaleNote;

  /// No description provided for @decision_editor_ahpEqual.
  ///
  /// In en, this message translates to:
  /// **'Equal importance'**
  String get decision_editor_ahpEqual;

  /// No description provided for @decision_editor_ahpModerate.
  ///
  /// In en, this message translates to:
  /// **'{stronger} moderately > {weaker}'**
  String decision_editor_ahpModerate(Object stronger, Object weaker);

  /// No description provided for @decision_editor_ahpStrong.
  ///
  /// In en, this message translates to:
  /// **'{stronger} strongly > {weaker}'**
  String decision_editor_ahpStrong(Object stronger, Object weaker);

  /// No description provided for @decision_editor_ahpEqualShort.
  ///
  /// In en, this message translates to:
  /// **'Equal'**
  String get decision_editor_ahpEqualShort;

  /// No description provided for @decision_editor_ahpModerateShort.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get decision_editor_ahpModerateShort;

  /// No description provided for @decision_editor_ahpStrongShort.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get decision_editor_ahpStrongShort;

  /// No description provided for @decision_editor_evaluate.
  ///
  /// In en, this message translates to:
  /// **'Evaluate'**
  String get decision_editor_evaluate;

  /// No description provided for @decision_editor_evaluating.
  ///
  /// In en, this message translates to:
  /// **'Evaluating...'**
  String get decision_editor_evaluating;

  /// No description provided for @decision_editor_save.
  ///
  /// In en, this message translates to:
  /// **'Save decision'**
  String get decision_editor_save;

  /// No description provided for @decision_editor_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get decision_editor_saving;

  /// No description provided for @decision_editor_saved.
  ///
  /// In en, this message translates to:
  /// **'Decision saved'**
  String get decision_editor_saved;

  /// No description provided for @decision_editor_defaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Untitled decision'**
  String get decision_editor_defaultTitle;

  /// No description provided for @decision_editor_evaluatedChip.
  ///
  /// In en, this message translates to:
  /// **'Evaluated'**
  String get decision_editor_evaluatedChip;

  /// No description provided for @decision_editor_titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get decision_editor_titleLabel;

  /// No description provided for @decision_editor_titleHint.
  ///
  /// In en, this message translates to:
  /// **'What are you deciding?'**
  String get decision_editor_titleHint;

  /// No description provided for @decision_editor_optionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get decision_editor_optionsTitle;

  /// No description provided for @decision_editor_optionsDescription.
  ///
  /// In en, this message translates to:
  /// **'List every option you\'re considering.'**
  String get decision_editor_optionsDescription;

  /// No description provided for @decision_editor_optionHint.
  ///
  /// In en, this message translates to:
  /// **'Add an option'**
  String get decision_editor_optionHint;

  /// No description provided for @decision_editor_addOption.
  ///
  /// In en, this message translates to:
  /// **'Add option'**
  String get decision_editor_addOption;

  /// No description provided for @decision_editor_noOptions.
  ///
  /// In en, this message translates to:
  /// **'No options yet. Add at least two to compare.'**
  String get decision_editor_noOptions;

  /// No description provided for @decision_editor_criteriaTitle.
  ///
  /// In en, this message translates to:
  /// **'Criteria & weights'**
  String get decision_editor_criteriaTitle;

  /// No description provided for @decision_editor_criteriaDescription.
  ///
  /// In en, this message translates to:
  /// **'What matters? Set a relative weight for each criterion.'**
  String get decision_editor_criteriaDescription;

  /// No description provided for @decision_editor_criterionHint.
  ///
  /// In en, this message translates to:
  /// **'Add a criterion'**
  String get decision_editor_criterionHint;

  /// No description provided for @decision_editor_weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get decision_editor_weightLabel;

  /// No description provided for @decision_editor_addCriterion.
  ///
  /// In en, this message translates to:
  /// **'Add criterion'**
  String get decision_editor_addCriterion;

  /// No description provided for @decision_editor_weightsNote.
  ///
  /// In en, this message translates to:
  /// **'Weights are normalized automatically.'**
  String get decision_editor_weightsNote;

  /// No description provided for @decision_editor_noCriteria.
  ///
  /// In en, this message translates to:
  /// **'No criteria yet. Add what you care about.'**
  String get decision_editor_noCriteria;

  /// No description provided for @decision_editor_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get decision_editor_remove;

  /// No description provided for @decision_editor_scoresTitle.
  ///
  /// In en, this message translates to:
  /// **'Scores matrix'**
  String get decision_editor_scoresTitle;

  /// No description provided for @decision_editor_scoresDescription.
  ///
  /// In en, this message translates to:
  /// **'Score each option for every criterion (0-10 works well).'**
  String get decision_editor_scoresDescription;

  /// No description provided for @decision_editor_scoresEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add at least one option and one criterion to start scoring.'**
  String get decision_editor_scoresEmpty;

  /// No description provided for @decision_editor_scoreOptionHeader.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get decision_editor_scoreOptionHeader;

  /// No description provided for @decision_editor_scorePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'0-10'**
  String get decision_editor_scorePlaceholder;

  /// No description provided for @decision_editor_scoreRange.
  ///
  /// In en, this message translates to:
  /// **'Score must be between 1 and 10.'**
  String get decision_editor_scoreRange;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_languageLabel;

  /// No description provided for @decision_editor_resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get decision_editor_resultTitle;

  /// No description provided for @decision_editor_resultDescription.
  ///
  /// In en, this message translates to:
  /// **'Evaluate to see the weighted ranking.'**
  String get decision_editor_resultDescription;

  /// No description provided for @decision_editor_bestOption.
  ///
  /// In en, this message translates to:
  /// **'Best option'**
  String get decision_editor_bestOption;

  /// No description provided for @decision_editor_unknownOption.
  ///
  /// In en, this message translates to:
  /// **'Unknown option'**
  String get decision_editor_unknownOption;

  /// No description provided for @decision_editor_ranking.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get decision_editor_ranking;

  /// No description provided for @decision_editor_descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get decision_editor_descriptionLabel;

  /// No description provided for @decision_editor_descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add context or constraints (optional).'**
  String get decision_editor_descriptionHint;

  /// No description provided for @decision_editor_optionLabel.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get decision_editor_optionLabel;

  /// No description provided for @decision_editor_criterionLabel.
  ///
  /// In en, this message translates to:
  /// **'Criterion'**
  String get decision_editor_criterionLabel;

  /// No description provided for @decision_editor_scoreHint.
  ///
  /// In en, this message translates to:
  /// **'Tip: scores can be any numeric scale, e.g., 0-10.'**
  String get decision_editor_scoreHint;

  /// No description provided for @decision_editor_scoreDefaultZero.
  ///
  /// In en, this message translates to:
  /// **'Empty scores count as 0.'**
  String get decision_editor_scoreDefaultZero;

  /// No description provided for @decision_editor_validationOptions.
  ///
  /// In en, this message translates to:
  /// **'Add at least two options.'**
  String get decision_editor_validationOptions;

  /// No description provided for @decision_editor_validationCriteria.
  ///
  /// In en, this message translates to:
  /// **'Add at least one criterion.'**
  String get decision_editor_validationCriteria;

  /// No description provided for @decision_editor_validationScores.
  ///
  /// In en, this message translates to:
  /// **'{count} scores still empty (counted as 0).'**
  String decision_editor_validationScores(int count);

  /// No description provided for @decision_editor_fixValidation.
  ///
  /// In en, this message translates to:
  /// **'Complete the required fields to continue.'**
  String get decision_editor_fixValidation;

  /// No description provided for @decision_editor_templatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get decision_editor_templatesTitle;

  /// No description provided for @decision_editor_templatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Start from a preset and adjust.'**
  String get decision_editor_templatesDescription;

  /// No description provided for @decision_editor_templateApplied.
  ///
  /// In en, this message translates to:
  /// **'Template applied: {name}'**
  String decision_editor_templateApplied(Object name);

  /// No description provided for @decision_editor_templateCareer.
  ///
  /// In en, this message translates to:
  /// **'Career move'**
  String get decision_editor_templateCareer;

  /// No description provided for @decision_editor_templateCareerDesc.
  ///
  /// In en, this message translates to:
  /// **'Compare staying, switching, or freelancing.'**
  String get decision_editor_templateCareerDesc;

  /// No description provided for @decision_editor_templateCareer_optionStay.
  ///
  /// In en, this message translates to:
  /// **'Stay in current role'**
  String get decision_editor_templateCareer_optionStay;

  /// No description provided for @decision_editor_templateCareer_optionNewCompany.
  ///
  /// In en, this message translates to:
  /// **'Join a new company'**
  String get decision_editor_templateCareer_optionNewCompany;

  /// No description provided for @decision_editor_templateCareer_optionFreelance.
  ///
  /// In en, this message translates to:
  /// **'Go freelance / consulting'**
  String get decision_editor_templateCareer_optionFreelance;

  /// No description provided for @decision_editor_templateCareer_critComp.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get decision_editor_templateCareer_critComp;

  /// No description provided for @decision_editor_templateCareer_critGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth & learning'**
  String get decision_editor_templateCareer_critGrowth;

  /// No description provided for @decision_editor_templateCareer_critBalance.
  ///
  /// In en, this message translates to:
  /// **'Work-life balance'**
  String get decision_editor_templateCareer_critBalance;

  /// No description provided for @decision_editor_templateCareer_critStability.
  ///
  /// In en, this message translates to:
  /// **'Stability'**
  String get decision_editor_templateCareer_critStability;

  /// No description provided for @decision_editor_templateProduct.
  ///
  /// In en, this message translates to:
  /// **'Product decision'**
  String get decision_editor_templateProduct;

  /// No description provided for @decision_editor_templateProductDesc.
  ///
  /// In en, this message translates to:
  /// **'Build vs buy vs open-source.'**
  String get decision_editor_templateProductDesc;

  /// No description provided for @decision_editor_templateProduct_optionSaas.
  ///
  /// In en, this message translates to:
  /// **'Buy a SaaS'**
  String get decision_editor_templateProduct_optionSaas;

  /// No description provided for @decision_editor_templateProduct_optionBuild.
  ///
  /// In en, this message translates to:
  /// **'Build in-house'**
  String get decision_editor_templateProduct_optionBuild;

  /// No description provided for @decision_editor_templateProduct_optionOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Adopt open-source'**
  String get decision_editor_templateProduct_optionOpenSource;

  /// No description provided for @decision_editor_templateProduct_critCost.
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get decision_editor_templateProduct_critCost;

  /// No description provided for @decision_editor_templateProduct_critSpeed.
  ///
  /// In en, this message translates to:
  /// **'Time to value'**
  String get decision_editor_templateProduct_critSpeed;

  /// No description provided for @decision_editor_templateProduct_critScalability.
  ///
  /// In en, this message translates to:
  /// **'Scalability'**
  String get decision_editor_templateProduct_critScalability;

  /// No description provided for @decision_editor_templateProduct_critSupport.
  ///
  /// In en, this message translates to:
  /// **'Support & maintenance'**
  String get decision_editor_templateProduct_critSupport;

  /// No description provided for @decision_editor_templateTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel plan'**
  String get decision_editor_templateTravel;

  /// No description provided for @decision_editor_templateTravelDesc.
  ///
  /// In en, this message translates to:
  /// **'Pick the best trip style.'**
  String get decision_editor_templateTravelDesc;

  /// No description provided for @decision_editor_templateTravel_optionBeach.
  ///
  /// In en, this message translates to:
  /// **'Beach / relax'**
  String get decision_editor_templateTravel_optionBeach;

  /// No description provided for @decision_editor_templateTravel_optionCity.
  ///
  /// In en, this message translates to:
  /// **'City / culture'**
  String get decision_editor_templateTravel_optionCity;

  /// No description provided for @decision_editor_templateTravel_optionNature.
  ///
  /// In en, this message translates to:
  /// **'Nature / adventure'**
  String get decision_editor_templateTravel_optionNature;

  /// No description provided for @decision_editor_templateTravel_critBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get decision_editor_templateTravel_critBudget;

  /// No description provided for @decision_editor_templateTravel_critActivities.
  ///
  /// In en, this message translates to:
  /// **'Activities & experiences'**
  String get decision_editor_templateTravel_critActivities;

  /// No description provided for @decision_editor_templateTravel_critWeather.
  ///
  /// In en, this message translates to:
  /// **'Weather preference'**
  String get decision_editor_templateTravel_critWeather;

  /// No description provided for @decision_editor_templateTravel_critTravelTime.
  ///
  /// In en, this message translates to:
  /// **'Travel time'**
  String get decision_editor_templateTravel_critTravelTime;

  /// No description provided for @decision_editor_templateFinance.
  ///
  /// In en, this message translates to:
  /// **'Financial move'**
  String get decision_editor_templateFinance;

  /// No description provided for @decision_editor_templateFinanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose where to allocate funds.'**
  String get decision_editor_templateFinanceDesc;

  /// No description provided for @decision_editor_templateFinance_optionIndex.
  ///
  /// In en, this message translates to:
  /// **'Index funds / ETFs'**
  String get decision_editor_templateFinance_optionIndex;

  /// No description provided for @decision_editor_templateFinance_optionRealEstate.
  ///
  /// In en, this message translates to:
  /// **'Real estate'**
  String get decision_editor_templateFinance_optionRealEstate;

  /// No description provided for @decision_editor_templateFinance_optionCash.
  ///
  /// In en, this message translates to:
  /// **'Cash / savings'**
  String get decision_editor_templateFinance_optionCash;

  /// No description provided for @decision_editor_templateFinance_critRisk.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get decision_editor_templateFinance_critRisk;

  /// No description provided for @decision_editor_templateFinance_critReturn.
  ///
  /// In en, this message translates to:
  /// **'Return potential'**
  String get decision_editor_templateFinance_critReturn;

  /// No description provided for @decision_editor_templateFinance_critLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Liquidity'**
  String get decision_editor_templateFinance_critLiquidity;

  /// No description provided for @decision_editor_templateFinance_critHorizon.
  ///
  /// In en, this message translates to:
  /// **'Time horizon'**
  String get decision_editor_templateFinance_critHorizon;

  /// No description provided for @docs_title.
  ///
  /// In en, this message translates to:
  /// **'User Guide'**
  String get docs_title;

  /// No description provided for @docs_gettingStartedTitle.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get docs_gettingStartedTitle;

  /// No description provided for @docs_gettingStartedItem1.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google (web redirects, mobile in-app).'**
  String get docs_gettingStartedItem1;

  /// No description provided for @docs_gettingStartedItem2.
  ///
  /// In en, this message translates to:
  /// **'Home shows hero prompt, recent decisions, quick actions.'**
  String get docs_gettingStartedItem2;

  /// No description provided for @docs_createTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a Decision'**
  String get docs_createTitle;

  /// No description provided for @docs_createItem1.
  ///
  /// In en, this message translates to:
  /// **'Title & description: title required.'**
  String get docs_createItem1;

  /// No description provided for @docs_createItem2.
  ///
  /// In en, this message translates to:
  /// **'Options: add at least 2.'**
  String get docs_createItem2;

  /// No description provided for @docs_createItem3.
  ///
  /// In en, this message translates to:
  /// **'Criteria: add weights (1–10) and at least 1 criterion.'**
  String get docs_createItem3;

  /// No description provided for @docs_createItem4.
  ///
  /// In en, this message translates to:
  /// **'Scores: fill every option×criterion with scores 1–10.'**
  String get docs_createItem4;

  /// No description provided for @docs_createItem5.
  ///
  /// In en, this message translates to:
  /// **'Evaluate runs remote WSM, auto-saves after confirmation.'**
  String get docs_createItem5;

  /// No description provided for @docs_createItem6.
  ///
  /// In en, this message translates to:
  /// **'Unsaved edits trigger discard confirmation on back.'**
  String get docs_createItem6;

  /// No description provided for @docs_templatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get docs_templatesTitle;

  /// No description provided for @docs_templatesItem1.
  ///
  /// In en, this message translates to:
  /// **'Use Career/Product/Travel/Finance templates to prefill.'**
  String get docs_templatesItem1;

  /// No description provided for @docs_templatesItem2.
  ///
  /// In en, this message translates to:
  /// **'Edit any prefilled values before scoring.'**
  String get docs_templatesItem2;

  /// No description provided for @docs_resultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get docs_resultsTitle;

  /// No description provided for @docs_resultsItem1.
  ///
  /// In en, this message translates to:
  /// **'Best option, ranking with scores, meta info shown.'**
  String get docs_resultsItem1;

  /// No description provided for @docs_resultsItem2.
  ///
  /// In en, this message translates to:
  /// **'Debug data from Edge Function when available.'**
  String get docs_resultsItem2;

  /// No description provided for @docs_historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History & Search'**
  String get docs_historyTitle;

  /// No description provided for @docs_historyItem1.
  ///
  /// In en, this message translates to:
  /// **'View saved decisions; mobile infinite scroll, web paging.'**
  String get docs_historyItem1;

  /// No description provided for @docs_historyItem2.
  ///
  /// In en, this message translates to:
  /// **'Search by title/description.'**
  String get docs_historyItem2;

  /// No description provided for @docs_historyItem3.
  ///
  /// In en, this message translates to:
  /// **'Tap to open result (evaluated) or edit & re-evaluate.'**
  String get docs_historyItem3;

  /// No description provided for @docs_historyItem4.
  ///
  /// In en, this message translates to:
  /// **'Delete performs soft delete.'**
  String get docs_historyItem4;

  /// No description provided for @docs_languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get docs_languageTitle;

  /// No description provided for @docs_languageItem1.
  ///
  /// In en, this message translates to:
  /// **'Switch English/Bahasa via header icon or Settings.'**
  String get docs_languageItem1;

  /// No description provided for @docs_authTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get docs_authTitle;

  /// No description provided for @docs_authItem1.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In; logout in header with confirmation.'**
  String get docs_authItem1;

  /// No description provided for @docs_methodTitle.
  ///
  /// In en, this message translates to:
  /// **'Decision Method'**
  String get docs_methodTitle;

  /// No description provided for @docs_methodItem1.
  ///
  /// In en, this message translates to:
  /// **'Weighted Sum Model: normalize weights, multiply scores (1–10), sum and rank.'**
  String get docs_methodItem1;

  /// No description provided for @docs_methodItem2.
  ///
  /// In en, this message translates to:
  /// **'Computed in Supabase Edge Function `evaluate_decision`.'**
  String get docs_methodItem2;

  /// No description provided for @docs_methodItem3.
  ///
  /// In en, this message translates to:
  /// **'AHP & Fuzzy: accepted by the Edge Function; current build aggregates with provided weights/scores (pairwise/fuzzy inputs coming later).'**
  String get docs_methodItem3;

  /// No description provided for @history_viewResult.
  ///
  /// In en, this message translates to:
  /// **'View result'**
  String get history_viewResult;

  /// No description provided for @result_reliabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Reliability:'**
  String get result_reliabilityLabel;

  /// No description provided for @result_reliabilityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get result_reliabilityHigh;

  /// No description provided for @result_reliabilityMedium.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get result_reliabilityMedium;

  /// No description provided for @result_reliabilityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get result_reliabilityLow;

  /// No description provided for @result_reliabilityVeryLow.
  ///
  /// In en, this message translates to:
  /// **'Very Low'**
  String get result_reliabilityVeryLow;

  /// No description provided for @result_reliabilityNA.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get result_reliabilityNA;

  /// No description provided for @result_ahpConsistencyLabel.
  ///
  /// In en, this message translates to:
  /// **'AHP CR:'**
  String get result_ahpConsistencyLabel;

  /// No description provided for @result_stabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Stability'**
  String get result_stabilityLabel;

  /// No description provided for @result_overlapLabel.
  ///
  /// In en, this message translates to:
  /// **'Fuzzy overlap'**
  String get result_overlapLabel;

  /// No description provided for @result_notesTitle.
  ///
  /// In en, this message translates to:
  /// **'How to read this'**
  String get result_notesTitle;

  /// No description provided for @result_notesReliability.
  ///
  /// In en, this message translates to:
  /// **'Reliability mixes score margin, weight stability, and (for fuzzy) overlap; higher is more trustworthy.'**
  String get result_notesReliability;

  /// No description provided for @result_notesStability.
  ///
  /// In en, this message translates to:
  /// **'Stability simulates small weight tweaks; if the best option stays #1, the result is stable.'**
  String get result_notesStability;

  /// No description provided for @result_notesOverlap.
  ///
  /// In en, this message translates to:
  /// **'Fuzzy overlap shows how much the top fuzzy scores overlap; lower overlap = clearer winner.'**
  String get result_notesOverlap;

  /// No description provided for @result_notesAhpCr.
  ///
  /// In en, this message translates to:
  /// **'AHP CR checks consistency of your pairwise comparisons; aim for CR < 0.1.'**
  String get result_notesAhpCr;

  /// No description provided for @result_noRanking.
  ///
  /// In en, this message translates to:
  /// **'No ranking available yet.'**
  String get result_noRanking;

  /// No description provided for @result_debugData.
  ///
  /// In en, this message translates to:
  /// **'Debug data'**
  String get result_debugData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
