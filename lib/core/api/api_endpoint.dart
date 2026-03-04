import 'dart:io';

class ApiEndpoints {
  ApiEndpoints._(); // Private constructor

  // =================== Base URL ===================
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Android emulator
      return "http://10.0.2.2:8000/api";
    } else if (Platform.isIOS) {
      // iOS Simulator
      if (_isSimulator()) return "http://localhost:8000/api";

      // Real iPhone – replace with your Mac IP
      return "http://192.168.1.3:8000/api"; // <-- update if your Mac IP changes
    } else {
      // Desktop fallback
      return "http://localhost:8000/api";
    }
  }

  static bool _isSimulator() {
    if (!Platform.isIOS) return false;
    final sim = Platform.environment['SIMULATOR_DEVICE_NAME'];
    return sim != null;
  }

  // =================== Timeouts ===================
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // =================== Batch Endpoints ===================
  static const String genre = "/genre";
  static String genreById(String id) => "/genre/$id";

  // =================== User Endpoints ===================
  static const String userLogin = "/auth/login";
  static const String userRegister = "/auth/register";
  static const String uploadProfileImage = "/upload/profile-image";
  static String getProfileImage(String userId) => "/upload/profile-image/$userId";
}