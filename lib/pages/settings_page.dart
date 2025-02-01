import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_colors.dart';
import 'package:schedule_fit/widgets/schedule_fit_language_dialog.dart';
import 'package:schedule_fit/widgets/schedule_fit_switch.dart';

import '../enums/schedule_fit_images.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../widgets/schedule_fit_contacts_dialog.dart';
import '../widgets/schedule_fit_drawer.dart';
import '../widgets/schedule_fit_info_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.impostazioni),
        ),
        drawer: ScheduleFitDrawer(
          onSave: () {},
        ),
        body: Card(
          color: ThemeProvider.getColor(AppColors.primaryColor),
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Notifications Switch
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Image(
                              image: AssetImage(getImage(Images.notification)),
                              width: 38,
                              height: 38,
                            ),
                            horizontalTitleGap: 30,
                            title: Text(
                              AppLocalizations.of(context)!.notifiche,
                              style: TextStyle(
                                fontSize: 24,
                                color: ThemeProvider.getColor(
                                    AppColors.secondaryColor),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ScheduleFitSwitch(
                              imageActive: Images.check,
                              imageNotActive: Images.cross,
                              colorActive: ThemeProvider.getColor(
                                      AppColors.checkColor) ??
                                  const Color(0xFF3A8A3D),
                              colorNotActive: ThemeProvider.getColor(
                                      AppColors.crossColor) ??
                                  const Color(0xFF850909),
                              currentValue: false,
                              onChanged: (value) =>
                                  () //TODO implementare switch notifiche,
                              ),
                        )
                      ],
                    ),
                  ),
                ),

                ///App Theme Switch
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Image(
                              image: AssetImage(getImage(Images.theme)),
                              width: 38,
                              height: 38,
                            ),
                            horizontalTitleGap: 26,
                            title: Text(
                              AppLocalizations.of(context)!.tema,
                              style: TextStyle(
                                fontSize: 24,
                                color: ThemeProvider.getColor(
                                    AppColors.secondaryColor),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ScheduleFitSwitch(
                            imageActive: Images.sun,
                            imageNotActive: Images.moon,
                            colorActive: ThemeProvider.getColor(
                                    AppColors.secondaryColor) ??
                                const Color(0xFFFBC24C),
                            colorNotActive: ThemeProvider.getColor(
                                    AppColors.primaryColor) ??
                                const Color(0xFF556EAA),
                            currentValue:
                                Provider.of<ThemeProvider>(context).isLightMode,
                            onChanged: (value) => Provider.of<ThemeProvider>(context,
                                    listen: false)
                                .toggleTheme(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                ///Language Dialog
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: GestureDetector(
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
                        leading: Image(
                          image: AssetImage(getImage(Images.language)),
                          width: 38,
                          height: 38,
                        ),
                        horizontalTitleGap: 28,
                        title: Text(
                          AppLocalizations.of(context)!.lingua,
                          style: TextStyle(
                            fontSize: 24,
                            color: ThemeProvider.getColor(
                                AppColors.secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                ///Contacts Page
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: GestureDetector(
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
                        leading: Image(
                          image: AssetImage(getImage(Images.social)),
                          width: 38,
                          height: 38,
                        ),
                        horizontalTitleGap: 28,
                        title: Text(
                          AppLocalizations.of(context)!.contatti,
                          style: TextStyle(
                            fontSize: 24,
                            color: ThemeProvider.getColor(
                                AppColors.secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                ///Info Page
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 20),
                  child: GestureDetector(
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
                          size: 40,
                        ),
                        horizontalTitleGap: 26,
                        title: Text(
                          AppLocalizations.of(context)!.info,
                          style: TextStyle(
                            fontSize: 24,
                            color: ThemeProvider.getColor(
                                AppColors.secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
