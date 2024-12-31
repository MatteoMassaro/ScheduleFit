import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/pages/calendar_page.dart';
import 'package:schedule_fit/widgets/schedule_fit_contacts_dialog.dart';
import 'package:schedule_fit/widgets/schedule_fit_drawer_header.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercises_dialog.dart';
import 'package:schedule_fit/widgets/schedule_fit_info_dialog.dart';
import 'package:schedule_fit/widgets/schedule_fit_language_dialog.dart';

import '../enums/schedule_fit_colors.dart';
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
      backgroundColor: getAppColors(AppColors.primaryColor),
      child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const ScheduleFitDrawerHeader(),

            ///My Training Page
            GestureDetector(
              onTap: () {
                if (pageProvider.paginaCorrente !=
                    (AppLocalizations.of(context)?.mioAllenamento ?? '')) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      pageProvider.setCurrentPage(
                          AppLocalizations.of(context)?.mioAllenamento ?? '');
                      return const HomePage();
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
                if (pageProvider.paginaCorrente !=
                    (AppLocalizations.of(context)?.calendario ?? '')) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      pageProvider.setCurrentPage(
                          AppLocalizations.of(context)?.calendario ?? '');
                      return const CalendarPage();
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: ImageIcon(
                    AssetImage(getImage(Images.calendar)),
                    size: 30,
                    color: Colors.white,
                  ),
                  tileColor: pageProvider.paginaCorrente ==
                          AppLocalizations.of(context)?.calendario
                      ? Colors.black12
                      : null,
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
                    return const ScheduleFitContactsDialog();
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
                    return const ScheduleFitInfoDialog();
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
