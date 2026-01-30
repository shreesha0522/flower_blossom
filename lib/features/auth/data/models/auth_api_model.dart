import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel {
  final String? authId;
  final String fullName;
  final String email;
  final String username;
  final String? password;
  final String? confirmPassword;
  final String? profilePicture;

  AuthApiModel({
    this.authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    this.confirmPassword,
    this.profilePicture,
  });

  // info: To JSON - ✅ CORRECTED to match backend expectations
  Map<String, dynamic> toJson() {
    return {
      "name": fullName, // ✅ Backend expects "name" not "fullName"
      "email": email,
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword,
      "profilePicture": profilePicture,
    };
  }

  // info: from JSON - ✅ CORRECTED to properly parse backend response
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      authId: json["_id"] as String?,
      fullName: json["name"] as String? ?? json["username"] as String, // ✅ Backend returns "name"
      email: json["email"] as String,
      username: json["username"] as String,
      profilePicture: json["profilePicture"] as String?,
    );
  }

  // info: to entity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      username: username,
      confirmPassword: confirmPassword,
      profilePicture: profilePicture,
    );
  }

  // info: from entity - ✅ CORRECTED to include confirmPassword
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      confirmPassword: entity.confirmPassword, // ✅ ADDED
      profilePicture: entity.profilePicture,
    );
  }

  // info: to entity list
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}