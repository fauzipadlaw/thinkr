import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkr/core/localization/app_locale.dart';
import 'package:thinkr/features/settings/presentation/settings_cubit.dart';
import 'package:thinkr/features/settings/presentation/settings_state.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:thinkr/core/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings_title),
        leading: BackButton(
          onPressed: () {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            } else {
              GoRouter.of(context).go(AppRoutes.home);
            }
          },
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.settings_languageLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: AppLocale.values.map((locale) {
                    final isSelected = state.locale == locale;
                    return ChoiceChip(
                      label: Text(
                        locale == AppLocale.en ? 'English' : 'Bahasa Indonesia',
                      ),
                      selected: isSelected,
                      onSelected: (_) => context
                          .read<SettingsCubit>()
                          .changeLanguage(locale),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
