// user_storage.dart

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.password,
  });
}

class UserStorage {
  static User? _user; // Store a single registered user

  // ✅ Register a user with all information
  static void register({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String password,
  }) {
    _user = User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      address: address,
      password: password,
    );
  }

  // ✅ Login → returns the User if credentials match, else null
  static User? loginUser(String email, String password) {
    if (_user != null && _user!.email == email && _user!.password == password) {
      return _user;
    }
    return null;
  }

  // ✅ Getter methods for easy access (optional)
  static String? get firstName => _user?.firstName;
  static String? get lastName => _user?.lastName;
  static String? get email => _user?.email;
  static String? get address => _user?.address;
}
