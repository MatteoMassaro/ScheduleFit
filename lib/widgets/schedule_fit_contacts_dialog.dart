import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enums/schedule_fit_app_info.dart';
import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_images.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class ScheduleFitContactsDialog extends StatelessWidget {
  const ScheduleFitContactsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
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
            ///Instagram
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                launchUrl(Uri.parse(getAppInfo(AppInfo.developerInstagram)));
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
                        padding: const EdgeInsets.only(right: 22),
                        child: Image(
                          image: AssetImage(getImage(Images.instagram)),
                          width: 40,
                          height: 40,
                        )),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.instagram,
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

            ///Email
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                    scheme: 'mailto', path: getAppInfo(AppInfo.developerMail));
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
                        padding: const EdgeInsets.only(right: 22),
                        child: Image(
                          image: AssetImage(getImage(Images.email)),
                          width: 40,
                          height: 40,
                        )),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.email,
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

            ///Website
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                launchUrl(Uri.parse(getAppInfo(AppInfo.developerWebSite)));
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
                          image: AssetImage(getImage(Images.website)),
                          width: 45,
                          height: 45,
                        )),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.sitoWeb,
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
