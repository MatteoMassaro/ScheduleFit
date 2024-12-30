import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_app_info.dart';
import 'package:schedule_fit/widgets/schedule_fit_drawer_header.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercises_dialog.dart';
import 'package:schedule_fit/widgets/schedule_fit_language_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enums/schedule_fit_images.dart';
import '../l10n/app_localizations.dart';
import '../pages/home_page.dart';
import '../providers/locale_provider.dart';
import '../providers/page_provider.dart';

class ScheduleFitDrawer extends StatefulWidget {
  final VoidCallback onSave;

  const ScheduleFitDrawer({super.key, required this.onSave});

  @override
  State<ScheduleFitDrawer> createState() => _ScheduleFitDrawerState();
}

class _ScheduleFitDrawerState extends State<ScheduleFitDrawer> {
  late LocaleProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<LocaleProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF556EAA),
      child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const ScheduleFitDrawerHeader(),

            ///My Exercise Page
            GestureDetector(
              onTap: () {
                if (pageProvider.paginaCorrente !=
                    (AppLocalizations.of(context)?.mioAllenamento ?? '')) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      pageProvider.setCurrentPage(
                          AppLocalizations.of(context)?.mioAllenamento ?? '');
                      return HomePage(
                          title: AppLocalizations.of(context)!.mioAllenamento);
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: ImageIcon(
                    AssetImage(getImage(Images.myTraining)),
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

            ///Create Exercise Card Page
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ScheduleFitExercisesDialog(onSave: widget.onSave);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: ImageIcon(
                    AssetImage(getImage(Images.createCard)),
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

            ///Calendar Page
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
                  leading: ImageIcon(
                    AssetImage(getImage(Images.calendar)),
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

            ///Language Page
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ScheduleFitLanguageDialog();
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

            ///Contacts Page
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
                                    getAppInfo(AppInfo.developerInstagram)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Image(
                                          image: AssetImage(
                                              getImage(Images.instagram)),
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
                                    path: getAppInfo(AppInfo.developerMail));
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
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Image(
                                          image: AssetImage(
                                              getImage(Images.email)),
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
                                    getAppInfo(AppInfo.developerWebSite)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Image(
                                          image: AssetImage(
                                              getImage(Images.website)),
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
                  leading: ImageIcon(
                    AssetImage(getImage(Images.social)),
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

            ///Info Page
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
                                    getImage(Images.icon),
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
                                            Text(
                                              getAppInfo(AppInfo.appVersion),
                                              style: const TextStyle(
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
                                                Text(
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  getAppInfo(
                                                      AppInfo.developerName),
                                                  style: const TextStyle(
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
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.info,
                      style: const TextStyle(
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
