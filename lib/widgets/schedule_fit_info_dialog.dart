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
                ///App Icon
                Image.asset(
                  getImage(Images.appIcon),
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ///App Name
                  Row(children: [
                    const Text(
                      maxLines: 1,
                      "SCHEDULE",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      "FIT",
                      style: TextStyle(
                        fontSize: 20,
                        color: ThemeProvider.getColor(AppColors.secondaryColor),
                      ),
                    )
                  ]),

                  ///Version
                  Text(
                    maxLines: 1,
                    '${AppLocalizations.of(context)!.versione} ${getAppInfo(AppInfo.appVersion)}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),

                  ///Author
                  Text(
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    '${AppLocalizations.of(context)!.autore} ${getAppInfo(AppInfo.developerName)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  )
                ])
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
                        maxLines: 3,
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
          ]),
        ),
      ),
      actions: <Widget>[
        ///Close Button
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
