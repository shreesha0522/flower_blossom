// user_storage.dart
class User {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });
}

class UserStorage {
  static User? _user;

  // Register a user with all information
  static void register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) {
    _user = User(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
    );
  }

  // Login → returns the User if credentials match, else null
  static User? loginUser(String email, String password) {
    if (_user != null &&
        _user!.email == email &&
        _user!.password == password) {
      return _user;
    }
    return null;
  }

  // Get current logged-in user
  static User? getCurrentUser() {
    return _user;
  }

  // Clear user data (logout)
  static void clearUser() {
    _user = null;
  }

  // Getter methods for easy access
  static String? get firstName => _user?.firstName;
  static String? get lastName => _user?.lastName;
  static String? get username => _user?.username;
  static String? get email => _user?.email;
  static String? get password => _user?.password;
}