import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:thinkr/l10n/app_localizations.dart';
import 'package:thinkr/core/widgets/top_snackbar.dart';
import 'package:thinkr/core/theme/app_colors.dart';

import 'login_form_cubit.dart';
import 'login_form_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    return BlocProvider<LoginFormCubit>(
      create: (_) => LoginFormCubit(GetIt.I()),
      child: BlocListener<LoginFormCubit, LoginFormState>(
        listenWhen: (prev, curr) =>
            prev.errorMessage != curr.errorMessage ||
            prev.successMessage != curr.successMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            final msg = _localizeError(state.errorMessage!, loc);
            showTopSnackBar(context, msg, isError: true);
          } else if (state.successMessage != null) {
            final key = state.successMessage!;
            final msg = key == 'login_signupSuccess'
                ? loc.login_signupSuccess
                : loc.login_signinSuccess;
            showTopSnackBar(context, msg);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.bgDeep, AppColors.bgCard],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: IconButton(
                    color: Colors.white70,
                    icon: const Icon(Icons.menu_book_outlined),
                    tooltip: loc.docs_title,
                    onPressed: () => context.push('/docs'),
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          child: BlocBuilder<LoginFormCubit, LoginFormState>(
                            builder: (context, state) {
                              final cubit = context.read<LoginFormCubit>();
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    loc.appName,
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    state.isSignup
                                        ? loc.login_subtitleSignup
                                        : loc.login_subtitleSignin,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      TextFormField(
                                        key: const ValueKey('email-field'),
                                        initialValue: state.email,
                                        onChanged: cubit.updateEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        autofillHints: const [
                                          AutofillHints.username,
                                        ],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _fieldDecoration(
                                          label: loc.login_email,
                                          icon: Icons.mail_outline,
                                          errorText: state.emailError == null
                                              ? null
                                              : _localizeError(
                                                  state.emailError!,
                                                  loc,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        key: const ValueKey('password-field'),
                                        initialValue: state.password,
                                        onChanged: cubit.updatePassword,
                                        obscureText: _obscure,
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _fieldDecoration(
                                          label: loc.login_password,
                                          icon: Icons.lock_outline,
                                          errorText: state.passwordError == null
                                              ? null
                                              : _localizeError(
                                                  state.passwordError!,
                                                  loc,
                                                ),
                                          suffix: IconButton(
                                            color: Colors.white70,
                                            icon: Icon(
                                              _obscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscure = !_obscure;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      if (state.isSignup) ...[
                                        const SizedBox(height: 12),
                                        TextFormField(
                                          key: const ValueKey(
                                            'confirm-password-field',
                                          ),
                                          initialValue: state.confirmPassword,
                                          onChanged:
                                              cubit.updateConfirmPassword,
                                          obscureText: _obscure,
                                          autofillHints: const [
                                            AutofillHints.password,
                                          ],
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: _fieldDecoration(
                                            label: loc.login_confirmPassword,
                                            icon: Icons.check_circle_outline,
                                            errorText:
                                                state.confirmError == null
                                                ? null
                                                : _localizeError(
                                                    state.confirmError!,
                                                    loc,
                                                  ),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: state.isSubmitting
                                              ? null
                                              : cubit.submit,
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 18,
                                            ),
                                            backgroundColor: Colors.blueAccent,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: state.isSubmitting
                                              ? const SizedBox(
                                                  width: 22,
                                                  height: 22,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2.4,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                          Colors.white,
                                                        ),
                                                  ),
                                                )
                                              : Text(
                                                  state.isSignup
                                                      ? loc.login_signupCta
                                                      : loc.login_signinCta,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      TextButton(
                                        onPressed: state.isSubmitting
                                            ? null
                                            : cubit.toggleMode,
                                        child: Text(
                                          state.isSignup
                                              ? loc.login_haveAccount
                                              : loc.login_needAccount,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.white.withValues(alpha: 0.2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        loc.login_orContinueWith,
                                        style: const TextStyle(
                                          color: Colors.white54,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.white.withValues(alpha: 0.2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  OutlinedButton.icon(
                                    onPressed: state.isSubmitting
                                        ? null
                                        : () => cubit.signInWithGoogle(),
                                    icon: const Icon(
                                      Icons.login,
                                      color: Colors.white,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.white.withValues(alpha: 0.3),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    label: Text(loc.login_signInWithGoogle),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    String? errorText,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffix,
      errorText: errorText,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.06),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  String _localizeError(String key, AppLocalizations loc) {
    switch (key) {
      case 'login_emailRequired':
        return loc.login_emailRequired;
      case 'login_emailInvalid':
        return loc.login_emailInvalid;
      case 'login_passwordRequired':
        return loc.login_passwordRequired;
      case 'login_passwordTooShort':
        return loc.login_passwordTooShort;
      case 'login_passwordMismatch':
        return loc.login_passwordMismatch;
      default:
        return key;
    }
  }
}
