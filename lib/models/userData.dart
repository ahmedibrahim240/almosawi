class UserDate {
  final String userName;
  final String userEmail;
  final String userImage;
  final String userPhoneNamber;

  UserDate(
      {this.userName, this.userEmail, this.userImage, this.userPhoneNamber});
}

UserDate userDate = UserDate(
  userName: 'A.Kahraba',
  userImage: 'lib/images/user.jpg',
  userEmail: 'AhmedIbrahim1310@ilcoud.com',
  userPhoneNamber: '0155105150',
);

class User {
  static int userid;
  static String proChat;
  static String courses;
  static String recomendations;
  static String userStutes;
  static String userGender;
  static String userPassword;
  static var appLang;
  static var apiLang;
  static String userlat;
  static String userlong;
  static String prefs;
  static bool userLogIn;
  static bool userSkipLogIn;
  static bool userBuyPlan;
  static bool userCantBuy;
}

class UserToken {
  final String userTohen;

  UserToken({this.userTohen});
}
