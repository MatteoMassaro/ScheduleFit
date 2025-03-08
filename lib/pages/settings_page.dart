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
    return SafeArea(
      child: Scaffold(
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: ListTile(
                            leading: Image(
                              image: AssetImage(getImage(Images.notification)),
                              width: 38,
                              height: 38,
                            ),
                            horizontalTitleGap: 25,
                            title: Text(
                              AppLocalizations.of(context)!.notifiche,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 24,
                                color: ThemeProvider.getColor(
                                    AppColors.secondaryColor),
                                height: 1.2
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
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
                          ),
                        )
                      ],
                    ),
                  ),
      
                  ///App Theme Switch
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: ListTile(
                            leading: Image(
                              image: AssetImage(getImage(Images.theme)),
                              width: 36,
                              height: 36,
                            ),
                            horizontalTitleGap: 25,
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
                        Expanded(
                          flex: 3,
                          child: Padding(
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
                              onChanged: (value) => Provider.of<ThemeProvider>(
                                      context,
                                      listen: false)
                                  .toggleTheme(),
                            ),
                          ),
                        )
                      ],
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ScheduleFitLanguageDialog();
                          },
                        );
                      },
                      child: ListTile(
                        leading: Image(
                          image: AssetImage(getImage(Images.language)),
                          width: 38,
                          height: 38,
                        ),
                        horizontalTitleGap: 25,
                        title: Text(
                          AppLocalizations.of(context)!.lingua,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 24,
                            color:
                                ThemeProvider.getColor(AppColors.secondaryColor),
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ScheduleFitContactsDialog();
                          },
                        );
                      },
                      child: ListTile(
                        leading: Image(
                          image: AssetImage(getImage(Images.social)),
                          width: 38,
                          height: 38,
                        ),
                        horizontalTitleGap: 22,
                        title: Text(
                          AppLocalizations.of(context)!.contatti,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 24,
                            color:
                                ThemeProvider.getColor(AppColors.secondaryColor),
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ScheduleFitInfoDialog();
                          },
                        );
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 40,
                        ),
                        horizontalTitleGap: 20,
                        title: Text(
                          AppLocalizations.of(context)!.info,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 24,
                            color:
                                ThemeProvider.getColor(AppColors.secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
