import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_pages.dart';
import 'package:schedule_fit/pages/calendar_page.dart';
import 'package:schedule_fit/pages/settings_page.dart';
import 'package:schedule_fit/widgets/schedule_fit_drawer_header.dart';
import 'package:schedule_fit/widgets/schedule_fit_exercises_dialog.dart';

import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_images.dart';
import '../l10n/app_localizations.dart';
import '../pages/home_page.dart';
import '../providers/locale_provider.dart';
import '../providers/page_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitDrawer extends StatefulWidget {
  final VoidCallback onSave;

  const ScheduleFitDrawer({super.key, required this.onSave});

  @override
  State<ScheduleFitDrawer> createState() => _ScheduleFitDrawerState();
}

class _ScheduleFitDrawerState extends State<ScheduleFitDrawer> {
  late LocaleProvider localeProvider;

  @override
  void initState() {
    super.initState();
    localeProvider = Provider.of<LocaleProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
      child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const ScheduleFitDrawerHeader(),

            ///My Training Page
            GestureDetector(
              onTap: () {
                if (pageProvider.paginaCorrente != Pages.mioAllenamento.name) {
                  pageProvider.setCurrentPage(Pages.mioAllenamento.name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
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
                  tileColor:
                      pageProvider.paginaCorrente == Pages.mioAllenamento.name
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
                if (pageProvider.paginaCorrente != Pages.calendario.name) {
                  pageProvider.setCurrentPage(Pages.calendario.name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalendarPage(),
                    ),
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
                  tileColor:
                      pageProvider.paginaCorrente == Pages.calendario.name
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

            ///Settings Page
            GestureDetector(
              onTap: () {
                if (pageProvider.paginaCorrente != Pages.impostazioni.name) {
                  pageProvider.setCurrentPage(Pages.impostazioni.name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListTile(
                  leading: const Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                  tileColor:
                      pageProvider.paginaCorrente == Pages.impostazioni.name
                          ? Colors.black12
                          : null,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.impostazioni,
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
