import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:inbridge/features/login/domain/entities/User.dart';

@Entity(tableName: 'user', primaryKeys: ['id'])
class UserModel extends UserEntity {
  final int? id;
  final List<String>? privateGallery;
  final List<String>? publicGallery;
  final File? photo;
  //final String? userEntityName;
  final String? email;
  final bool blocked;
  final bool admin;
  final String? description;

  UserModel.initial()
      : super(
            id = null,
            privateGallery = null,
            publicGallery = null,
            photo = null,
            //userEntityName = null,
            email = null,
            blocked = false,
            admin = false,
            description = null);

  UserModel({
    required List<String>? privateGallery,
    required List<String>? publicGallery,
    required File? photo,
    //required String? userEntityName,
    required String? email,
    required int? id,
    required String? description,
    bool blocked = false,
    bool admin = false,
  }) : super(
            id = id,
            privateGallery = privateGallery,
            publicGallery = publicGallery,
            photo = photo,
            //userEntityName = userEntityName,
            email = email,
            blocked = blocked,
            admin = admin,
            description = description);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      privateGallery: (map['privateGallery'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publicGallery: (map['publicGallery'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      photo: map['photo'] != null ? File(map['photo']) : null,
      //userEntityName: map['userEntityName'] as String?,
      email: map['email'] as String?,
      id: map['id'] as int?,
      description: map['description'] as String?,
      blocked: map['blocked'] as bool? ?? false,
      admin: map['admin'] as bool? ?? false,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      privateGallery: entity.privateGallery,
      publicGallery: entity.publicGallery,
      photo: entity.photo,
      email: entity.email,
      blocked: entity.blocked,
      admin: entity.admin,
      description: entity.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        privateGallery,
        publicGallery,
        photo,
        // userEntityName,
        email,
        blocked,
        admin,
        description,
      ];

  @override
  bool? get stringify => true; // If you want to enable toString() in Equatable
}
