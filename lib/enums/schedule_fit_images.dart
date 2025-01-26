enum Images {
  calendar,
  createCard,
  email,
  icon,
  instagram,
  myTraining,
  social,
  info,
  website,
  playStore,
  privacyPolicy,
  language,
  notification,
  theme,
  sun,
  moon,
  check,
  cross
}

Map<Images, String> imageUrl = {
  Images.calendar: 'assets/images/calendar.png',
  Images.createCard: 'assets/images/createCard.png',
  Images.email: 'assets/images/email.png',
  Images.icon: 'assets/images/icon.png',
  Images.instagram: 'assets/images/instagram.png',
  Images.myTraining: 'assets/images/myTraining.png',
  Images.social: 'assets/images/social.png',
  Images.info: 'assets/images/info.png',
  Images.website: 'assets/images/website.png',
  Images.playStore: 'assets/images/playStore.png',
  Images.privacyPolicy: 'assets/images/privacyPolicy.png',
  Images.language: 'assets/images/language.png',
  Images.notification: 'assets/images/notification.png',
  Images.theme: 'assets/images/theme.png',
  Images.sun: 'assets/images/sun.png',
  Images.moon: 'assets/images/moon.png',
  Images.check: 'assets/images/check.png',
  Images.cross: 'assets/images/cross.png',
};

String getImage(Images image) {
  return imageUrl[image] ?? '';
}
