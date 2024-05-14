import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/locale_provider.dart';

class LocaleSwitcherWidget extends StatelessWidget {
  const LocaleSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: AppLocalizations.supportedLocales.map(
              (nextLocale) {
            return DropdownMenuItem(
              value: nextLocale,
              onTap: () {
                final provider =
                Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(nextLocale);
              },
              child: Center(
                child: Text(nextLocale.toString()),
              ),
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}