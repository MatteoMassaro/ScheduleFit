enum AppInfo {
  appName,
  appVersion,
  databaseName,
  fontFamily,
  defaultLanguage,
  defaultMeasurement,
  developerName,
  developerInstagram,
  developerMail,
  developerWebSite
}

Map<AppInfo, String> appInfo = {
  AppInfo.appName: 'ScheduleFit',
  AppInfo.appVersion: '1.0.0',
  AppInfo.databaseName: 'schedule_fit_database',
  AppInfo.fontFamily: 'Cooper Hewitt',
  AppInfo.defaultLanguage: 'it',
  AppInfo.defaultMeasurement: 'Kg',
  AppInfo.developerName: 'Matteo Massaro',
  AppInfo.developerInstagram: 'https://www.instagram.com/matteo__massaro/',
  AppInfo.developerMail: 'massaromatteo21@gmail.com',
  AppInfo.developerWebSite: 'https://matteomassaro.altervista.org/'
};

String getAppInfo(AppInfo info) {
  return appInfo[info] ?? '';
}
