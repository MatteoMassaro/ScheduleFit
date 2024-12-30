enum Images {
  calendar,
  createCard,
  email,
  icon,
  instagram,
  myTraining,
  social,
  website
}

Map<Images, String> imageUrl = {
  Images.calendar: 'assets/images/calendar.png',
  Images.createCard: 'assets/images/createCard.png',
  Images.email: 'assets/images/email.png',
  Images.icon: 'assets/images/icon.png',
  Images.instagram: 'assets/images/instagram.png',
  Images.myTraining: 'assets/images/myTraining.png',
  Images.social: 'assets/images/social.png',
  Images.website: 'assets/images/website.png',
};

String getImage(Images image) {
  return imageUrl[image] ?? '';
}
