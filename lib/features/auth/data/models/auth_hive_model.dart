import 'package:flower_blossom/core/constant/hive_table_constant.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// Generate Hive adapter: dart run build_runner build
part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject {
  @HiveField(0)
  final String authId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String username;

  @HiveField(4)
  final String? password;

  @HiveField(5)
  final String? profilePicture;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    this.profilePicture,
  }) : authId = authId ?? const Uuid().v4(); // use existing id or generate a new one

  // Convert Hive Model to Entity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      username: username,
      password: password,
      profilePicture: profilePicture,
    );
  }

  // Convert Entity to Hive Model
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      profilePicture: entity.profilePicture,
    );
  }

  // Convert list of Hive Models to list of Entities
  static List<AuthEntity> toEntityList(List<AuthHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
