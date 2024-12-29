import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class ScheduleFitLanguageDialog extends StatefulWidget {
  const ScheduleFitLanguageDialog({super.key});

  @override
  State<ScheduleFitLanguageDialog> createState() => _ScheduleFitLanguageDialogState();
}

class _ScheduleFitLanguageDialogState extends State<ScheduleFitLanguageDialog> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = Provider.of<LocaleProvider>(context, listen: false)
        .locale
        .languageCode;
  }

  ///Select Language
  void _selectLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(Locale(languageCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF556EAA),
      title: Text(
        AppLocalizations.of(context)!.lingua,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: ListView(shrinkWrap: true, children: [
            ///Italian
            GestureDetector(
              onTap: () => _selectLanguage('it'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CountryFlag.fromLanguageCode(
                        'it',
                        height: 36,
                        width: 50,
                        borderRadius: 8,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.italiano,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFfbc24c),
                      ),
                    ),
                    const Spacer(),
                    if (_selectedLanguage == 'it')
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ///English
            GestureDetector(
              onTap: () => _selectLanguage('en'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CountryFlag.fromLanguageCode(
                        'en',
                        height: 36,
                        width: 50,
                        borderRadius: 8,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.inglese,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFfbc24c),
                      ),
                    ),
                    const Spacer(),
                    if (_selectedLanguage == 'en')
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ///French
            GestureDetector(
              onTap: () => _selectLanguage('fr'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CountryFlag.fromLanguageCode(
                        'fr',
                        height: 36,
                        width: 50,
                        borderRadius: 8,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.francese,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFfbc24c),
                      ),
                    ),
                    const Spacer(),
                    if (_selectedLanguage == 'fr')
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ///Spanish
            GestureDetector(
              onTap: () => _selectLanguage('es'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CountryFlag.fromLanguageCode(
                        'es',
                        height: 36,
                        width: 50,
                        borderRadius: 8,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.spagnolo,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFfbc24c),
                      ),
                    ),
                    const Spacer(),
                    if (_selectedLanguage == 'es')
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ///German
            GestureDetector(
              onTap: () => _selectLanguage('de'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CountryFlag.fromLanguageCode(
                        'de',
                        height: 36,
                        width: 50,
                        borderRadius: 8,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.tedesco,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFfbc24c),
                      ),
                    ),
                    const Spacer(),
                    if (_selectedLanguage == 'de')
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.chiudi,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
