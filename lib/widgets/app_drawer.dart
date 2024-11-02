import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/widgets/exercises_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/page_provider.dart';
import '../screens/home_screen.dart';

class AppDrawer extends StatefulWidget {
  final VoidCallback onSave;
  const AppDrawer({super.key, required this.onSave});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late LocaleProvider provider;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<LocaleProvider>(context, listen: false);
    _selectedLanguage = provider.locale.toString();
  }

  void _selectLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(Locale(languageCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF556EAA),
      child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF556EAA)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/icon.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const Text(
                    "SCHEDULE",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "FIT",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFfbc24c),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (pageProvider.paginaCorrente !=
                    (AppLocalizations.of(context)?.mioAllenamento ??
                        'Il mio allenamento')) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      pageProvider.setCurrentPage(
                          AppLocalizations.of(context)?.mioAllenamento ??
                              'Il mio allenamento');
                      return HomePage(
                          title: AppLocalizations.of(context)!.mioAllenamento);
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const ImageIcon(
                    AssetImage("assets/images/myTraining.png"),
                    size: 30,
                    color: Colors.white,
                  ),
                  tileColor: pageProvider.paginaCorrente ==
                          AppLocalizations.of(context)?.mioAllenamento
                      ? Colors.black12
                      : null,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.mioAllenamento,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ExercisesDialog(onSave: widget.onSave);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const ImageIcon(
                    AssetImage("assets/images/createCard.png"),
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.creaScheda,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HomePage(
                        title: AppLocalizations.of(context)!.mioAllenamento);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const ImageIcon(
                    AssetImage("assets/images/calendar.png"),
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.calendario,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
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
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.lingua,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF556EAA),
                      title: Text(
                        AppLocalizations.of(context)!.contatti,
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
                            InkWell(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'https://www.instagram.com/matteo__massaro/'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/instagram.png"),
                                          width: 40,
                                          height: 40,
                                        )),
                                    Text(
                                      AppLocalizations.of(context)!.instagram,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFFfbc24c),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'massaromatteo21@gmail.com');
                                if (await canLaunchUrl(emailLaunchUri)) {
                                  await launchUrl(emailLaunchUri);
                                } else {
                                  throw 'Could not launch $emailLaunchUri';
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/email.png"),
                                          width: 40,
                                          height: 40,
                                        )),
                                    Text(
                                      AppLocalizations.of(context)!.email,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFFfbc24c),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'https://matteomassaro.altervista.org/'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/website.png"),
                                          width: 45,
                                          height: 45,
                                        )),
                                    Text(
                                      AppLocalizations.of(context)!.sitoWeb,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFFfbc24c),
                                      ),
                                    )
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
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const ImageIcon(
                    AssetImage("assets/images/social.png"),
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.contatti,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF556EAA),
                      title: Text(
                        AppLocalizations.of(context)!.info,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/icon.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(children: [
                                            Text(
                                              "SCHEDULE",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "FIT",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Color(0xFFfbc24c),
                                              ),
                                            )
                                          ]),
                                          Row(children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .versione,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Text(
                                              "1.0.0",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ]),
                                          Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .autore,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const Text(
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  "Matteo Massaro",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ])
                                        ]))
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  AppLocalizations.of(context)!.descrizioneApp,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFfbc24c),
                                  ),
                                )),
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
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Info",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
