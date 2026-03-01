import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel {
  final String? authId;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String? password;
  final String? confirmPassword;
  final String? profilePicture;

  AuthApiModel({
    this.authId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.password,
    this.confirmPassword,
    this.profilePicture,
  });

  // To JSON - sends firstName and lastName to backend
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword,
      "profilePicture": profilePicture,
    };
  }

  // From JSON - parses backend response
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      authId: json["_id"] as String?,
      firstName: json["firstName"] as String? ?? "",
      lastName: json["lastName"] as String? ?? "",
      email: json["email"] as String,
      username: json["username"] as String,
      profilePicture: json["profilePicture"] as String?,
    );
  }

  // To entity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      confirmPassword: confirmPassword,
      profilePicture: profilePicture,
    );
  }

  // From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      authId: entity.authId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
      profilePicture: entity.profilePicture,
    );
  }

  // To entity list
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}