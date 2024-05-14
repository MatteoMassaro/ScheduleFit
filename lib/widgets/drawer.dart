import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF556EAA),
      child: ListView(
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
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: ListTile(
              leading: Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Calendario",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: ListTile(
              leading: Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Calendario",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
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
      ),
    );
  }
}
