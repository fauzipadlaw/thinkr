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
  String get home_recentDecisions => 'Recent decisions';

  @override
  String get home_viewAllHistory => 'See all history';

  @override
  String get login_signIn => 'Sign in';

  @override
  String get login_signOut => 'Sign out';

  @override
  String get login_subtitleSignin => 'Welcome back. Sign in to continue.';

  @override
  String get login_subtitleSignup =>
      'Create an account to save your decisions.';

  @override
  String get login_email => 'Email';

  @override
  String get login_password => 'Password';

  @override
  String get login_confirmPassword => 'Confirm password';

  @override
  String get login_emailRequired => 'Email is required';

  @override
  String get login_emailInvalid => 'Enter a valid email address';

  @override
  String get login_passwordRequired => 'Password is required';

  @override
  String get login_passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get login_passwordMismatch => 'Passwords do not match';

  @override
  String get login_signinCta => 'Sign in';

  @override
  String get login_signupCta => 'Create account';

  @override
  String get login_needAccount => 'Need an account? Sign up';

  @override
  String get login_haveAccount => 'Already have an account? Sign in';

  @override
  String get login_orContinueWith => 'or continue with';

  @override
  String get login_signinSuccess => 'Signed in';

  @override
  String get login_signupSuccess => 'Account created';

  @override
  String get history_title => 'Decision history';

  @override
  String get history_emptyTitle => 'No decisions yet';

  @override
  String get history_emptySubtitle => 'Create a decision to see it here.';

  @override
  String get history_newDecision => 'New decision';

  @override
  String get history_options => 'options';

  @override
  String get history_criteria => 'criteria';

  @override
  String history_bestOption(Object option) {
    return 'Best: $option';
  }

  @override
  String get history_delete => 'Delete';

  @override
  String get history_errorTitle => 'Could not load history';

  @override
  String get history_retry => 'Retry';

  @override
  String get decision_editor_stepOptions => 'Add options';

  @override
  String get decision_editor_stepCriteria => 'Add criteria & weights';

  @override
  String get decision_editor_stepScores => 'Score each option';

  @override
  String get decision_editor_stepEvaluate => 'Next';

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

  @override
  String get decision_editor_title => 'Decision editor';

  @override
  String get decision_editor_subtitle =>
      'Add options, criteria, weights, and scores to get a ranked recommendation.';

  @override
  String get decision_editor_evaluate => 'Evaluate';

  @override
  String get decision_editor_evaluating => 'Evaluating...';

  @override
  String get decision_editor_save => 'Save decision';

  @override
  String get decision_editor_saving => 'Saving...';

  @override
  String get decision_editor_saved => 'Decision saved';

  @override
  String get decision_editor_defaultTitle => 'Untitled decision';

  @override
  String get decision_editor_evaluatedChip => 'Evaluated';

  @override
  String get decision_editor_titleLabel => 'Title';

  @override
  String get decision_editor_titleHint => 'What are you deciding?';

  @override
  String get decision_editor_optionsTitle => 'Options';

  @override
  String get decision_editor_optionsDescription =>
      'List every option you\'re considering.';

  @override
  String get decision_editor_optionHint => 'Add an option';

  @override
  String get decision_editor_addOption => 'Add option';

  @override
  String get decision_editor_noOptions =>
      'No options yet. Add at least two to compare.';

  @override
  String get decision_editor_criteriaTitle => 'Criteria & weights';

  @override
  String get decision_editor_criteriaDescription =>
      'What matters? Set a relative weight for each criterion.';

  @override
  String get decision_editor_criterionHint => 'Add a criterion';

  @override
  String get decision_editor_weightLabel => 'Weight';

  @override
  String get decision_editor_addCriterion => 'Add criterion';

  @override
  String get decision_editor_weightsNote =>
      'Weights are normalized automatically.';

  @override
  String get decision_editor_noCriteria =>
      'No criteria yet. Add what you care about.';

  @override
  String get decision_editor_remove => 'Remove';

  @override
  String get decision_editor_scoresTitle => 'Scores matrix';

  @override
  String get decision_editor_scoresDescription =>
      'Score each option for every criterion (0-10 works well).';

  @override
  String get decision_editor_scoresEmpty =>
      'Add at least one option and one criterion to start scoring.';

  @override
  String get decision_editor_scoreOptionHeader => 'Option';

  @override
  String get decision_editor_scorePlaceholder => '0-10';

  @override
  String get decision_editor_scoreRange => 'Score must be between 1 and 10.';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_languageLabel => 'Language';

  @override
  String get decision_editor_resultTitle => 'Result';

  @override
  String get decision_editor_resultDescription =>
      'Evaluate to see the weighted ranking.';

  @override
  String get decision_editor_bestOption => 'Best option';

  @override
  String get decision_editor_unknownOption => 'Unknown option';

  @override
  String get decision_editor_ranking => 'Ranking';

  @override
  String get decision_editor_descriptionLabel => 'Description';

  @override
  String get decision_editor_descriptionHint =>
      'Add context or constraints (optional).';

  @override
  String get decision_editor_optionLabel => 'Option';

  @override
  String get decision_editor_criterionLabel => 'Criterion';

  @override
  String get decision_editor_scoreHint =>
      'Tip: scores can be any numeric scale, e.g., 0-10.';

  @override
  String get decision_editor_scoreDefaultZero => 'Empty scores count as 0.';

  @override
  String get decision_editor_validationOptions => 'Add at least two options.';

  @override
  String get decision_editor_validationCriteria =>
      'Add at least one criterion.';

  @override
  String decision_editor_validationScores(int count) {
    return '$count scores still empty (counted as 0).';
  }

  @override
  String get decision_editor_fixValidation =>
      'Complete the required fields to continue.';

  @override
  String get decision_editor_templatesTitle => 'Templates';

  @override
  String get decision_editor_templatesDescription =>
      'Start from a preset and adjust.';

  @override
  String decision_editor_templateApplied(Object name) {
    return 'Template applied: $name';
  }

  @override
  String get decision_editor_templateCareer => 'Career move';

  @override
  String get decision_editor_templateCareerDesc =>
      'Compare staying, switching, or freelancing.';

  @override
  String get decision_editor_templateCareer_optionStay =>
      'Stay in current role';

  @override
  String get decision_editor_templateCareer_optionNewCompany =>
      'Join a new company';

  @override
  String get decision_editor_templateCareer_optionFreelance =>
      'Go freelance / consulting';

  @override
  String get decision_editor_templateCareer_critComp => 'Compensation';

  @override
  String get decision_editor_templateCareer_critGrowth => 'Growth & learning';

  @override
  String get decision_editor_templateCareer_critBalance => 'Work-life balance';

  @override
  String get decision_editor_templateCareer_critStability => 'Stability';

  @override
  String get decision_editor_templateProduct => 'Product decision';

  @override
  String get decision_editor_templateProductDesc =>
      'Build vs buy vs open-source.';

  @override
  String get decision_editor_templateProduct_optionSaas => 'Buy a SaaS';

  @override
  String get decision_editor_templateProduct_optionBuild => 'Build in-house';

  @override
  String get decision_editor_templateProduct_optionOpenSource =>
      'Adopt open-source';

  @override
  String get decision_editor_templateProduct_critCost => 'Total cost';

  @override
  String get decision_editor_templateProduct_critSpeed => 'Time to value';

  @override
  String get decision_editor_templateProduct_critScalability => 'Scalability';

  @override
  String get decision_editor_templateProduct_critSupport =>
      'Support & maintenance';

  @override
  String get decision_editor_templateTravel => 'Travel plan';

  @override
  String get decision_editor_templateTravelDesc => 'Pick the best trip style.';

  @override
  String get decision_editor_templateTravel_optionBeach => 'Beach / relax';

  @override
  String get decision_editor_templateTravel_optionCity => 'City / culture';

  @override
  String get decision_editor_templateTravel_optionNature =>
      'Nature / adventure';

  @override
  String get decision_editor_templateTravel_critBudget => 'Budget';

  @override
  String get decision_editor_templateTravel_critActivities =>
      'Activities & experiences';

  @override
  String get decision_editor_templateTravel_critWeather => 'Weather preference';

  @override
  String get decision_editor_templateTravel_critTravelTime => 'Travel time';

  @override
  String get decision_editor_templateFinance => 'Financial move';

  @override
  String get decision_editor_templateFinanceDesc =>
      'Choose where to allocate funds.';

  @override
  String get decision_editor_templateFinance_optionIndex =>
      'Index funds / ETFs';

  @override
  String get decision_editor_templateFinance_optionRealEstate => 'Real estate';

  @override
  String get decision_editor_templateFinance_optionCash => 'Cash / savings';

  @override
  String get decision_editor_templateFinance_critRisk => 'Risk';

  @override
  String get decision_editor_templateFinance_critReturn => 'Return potential';

  @override
  String get decision_editor_templateFinance_critLiquidity => 'Liquidity';

  @override
  String get decision_editor_templateFinance_critHorizon => 'Time horizon';

  @override
  String get docs_title => 'User Guide';

  @override
  String get docs_gettingStartedTitle => 'Getting Started';

  @override
  String get docs_gettingStartedItem1 =>
      'Sign in with Google (web redirects, mobile in-app).';

  @override
  String get docs_gettingStartedItem2 =>
      'Home shows hero prompt, recent decisions, quick actions.';

  @override
  String get docs_createTitle => 'Create a Decision';

  @override
  String get docs_createItem1 => 'Title & description: title required.';

  @override
  String get docs_createItem2 => 'Options: add at least 2.';

  @override
  String get docs_createItem3 =>
      'Criteria: add weights (1–10) and at least 1 criterion.';

  @override
  String get docs_createItem4 =>
      'Scores: fill every option×criterion with scores 1–10.';

  @override
  String get docs_createItem5 =>
      'Evaluate runs remote WSM, auto-saves after confirmation.';

  @override
  String get docs_createItem6 =>
      'Unsaved edits trigger discard confirmation on back.';

  @override
  String get docs_templatesTitle => 'Templates';

  @override
  String get docs_templatesItem1 =>
      'Use Career/Product/Travel/Finance templates to prefill.';

  @override
  String get docs_templatesItem2 => 'Edit any prefilled values before scoring.';

  @override
  String get docs_resultsTitle => 'Results';

  @override
  String get docs_resultsItem1 =>
      'Best option, ranking with scores, meta info shown.';

  @override
  String get docs_resultsItem2 =>
      'Debug data from Edge Function when available.';

  @override
  String get docs_historyTitle => 'History & Search';

  @override
  String get docs_historyItem1 =>
      'View saved decisions; mobile infinite scroll, web paging.';

  @override
  String get docs_historyItem2 => 'Search by title/description.';

  @override
  String get docs_historyItem3 =>
      'Tap to open result (evaluated) or edit & re-evaluate.';

  @override
  String get docs_historyItem4 => 'Delete performs soft delete.';

  @override
  String get docs_languageTitle => 'Language';

  @override
  String get docs_languageItem1 =>
      'Switch English/Bahasa via header icon or Settings.';

  @override
  String get docs_authTitle => 'Authentication';

  @override
  String get docs_authItem1 =>
      'Google Sign-In; logout in header with confirmation.';

  @override
  String get docs_methodTitle => 'Decision Method';

  @override
  String get docs_methodItem1 =>
      'Weighted Sum Model: normalize weights, multiply scores (1–10), sum and rank.';

  @override
  String get docs_methodItem2 =>
      'Computed in Supabase Edge Function `evaluate_decision`.';
}
