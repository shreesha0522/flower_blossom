class UserStorage {
  static String? email;
  static String? password;

  static void register(String regEmail, String regPassword) {
    email = regEmail;
    password = regPassword;
  }

  static bool login(String inputEmail, String inputPassword) {
    return email == inputEmail && password == inputPassword;
  }
}
