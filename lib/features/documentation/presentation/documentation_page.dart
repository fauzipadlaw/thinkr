import 'package:flutter/material.dart';
import 'package:thinkr/core/extensions/context_extension.dart';
import 'package:thinkr/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    final sections = _sections(loc);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.docs_title),
        leading: BackButton(
          onPressed: () {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            } else {
              GoRouter.of(context).go('/app/home');
            }
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final section = sections[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              title: Text(
                section.title,
                style: theme.textTheme.titleMedium,
              ),
              children: section.body
                  .map((line) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(child: Text(line)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  List<_DocSection> _sections(AppLocalizations loc) => [
        _DocSection(
          loc.docs_gettingStartedTitle,
          [
            loc.docs_gettingStartedItem1,
            loc.docs_gettingStartedItem2,
          ],
        ),
        _DocSection(
          loc.docs_createTitle,
          [
            loc.docs_createItem1,
            loc.docs_createItem2,
            loc.docs_createItem3,
            loc.docs_createItem4,
            loc.docs_createItem5,
            loc.docs_createItem6,
          ],
        ),
        _DocSection(
          loc.docs_templatesTitle,
          [
            loc.docs_templatesItem1,
            loc.docs_templatesItem2,
          ],
        ),
        _DocSection(
          loc.docs_resultsTitle,
          [
            loc.docs_resultsItem1,
            loc.docs_resultsItem2,
          ],
        ),
        _DocSection(
          loc.docs_historyTitle,
          [
            loc.docs_historyItem1,
            loc.docs_historyItem2,
            loc.docs_historyItem3,
            loc.docs_historyItem4,
          ],
        ),
        _DocSection(
          loc.docs_languageTitle,
          [
            loc.docs_languageItem1,
          ],
        ),
        _DocSection(
          loc.docs_authTitle,
          [
            loc.docs_authItem1,
          ],
        ),
        _DocSection(
          loc.docs_methodTitle,
          [
            loc.docs_methodItem1,
            loc.docs_methodItem2,
            loc.docs_methodItem3,
          ],
        ),
      ];
}

class _DocSection {
  final String title;
  final List<String> body;
  const _DocSection(this.title, this.body);
}
