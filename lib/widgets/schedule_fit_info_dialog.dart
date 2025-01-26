import 'package:flutter/material.dart';

import '../enums/schedule_fit_app_info.dart';
import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_images.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class ScheduleFitInfoDialog extends StatelessWidget {
  const ScheduleFitInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Text(
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
                                color: ThemeProvider.getColor(
                                    AppColors.secondaryColor),
                              ),
                            )
                          ]),
                          Row(children: [
                            Text(
                              AppLocalizations.of(context)!.versione,
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
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              AppLocalizations.of(context)!.autore,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              getAppInfo(AppInfo.developerName),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ])
                        ]))
              ],
            ),

            const SizedBox(height: 10),

            ///Play Store
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                //launchUrl(Uri.parse(getAppInfo(AppInfo.developerInstagram)));
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
                        padding: const EdgeInsets.only(right: 15),
                        child: Image(
                          image: AssetImage(getImage(Images.playStore)),
                          width: 40,
                          height: 40,
                        )),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.valutami,
                        style: TextStyle(
                          fontSize: 24,
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            ///Privacy Policy
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                //launchUrl(Uri.parse(getAppInfo(AppInfo.developerInstagram)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image(
                        image: AssetImage(getImage(Images.privacyPolicy)),
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.politicaRiservatezza,
                        style: TextStyle(
                          fontSize: 24,
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor),
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            )

            // Padding(
            //     padding: const EdgeInsets.only(top: 15),
            //     child: Text(
            //       AppLocalizations.of(context)!.descrizioneApp,
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 20,
            //         color: getAppColors(AppColors.secondaryColor),
            //       ),
            //     )),
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
