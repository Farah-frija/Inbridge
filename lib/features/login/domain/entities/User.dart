import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final List<String>? privateGallery;
  final List<String>? publicGallery;
  final File? photo;
  final String? userEntityName;
  final String? email;
  final bool blocked;
  final bool admin;
  final String? description;

  UserEntity({
    required List<String>? privateGallery,
    required List<String>? publicGallery,
    required File? photo,
    required String? userEntityName,
    required String? email,
    required int? id,
    required String? description,
    bool blocked = false,
    bool admin = false,
  })  : id = id,
        privateGallery = privateGallery,
        publicGallery = publicGallery,
        photo = photo,
        userEntityName = userEntityName,
        email = email,
        blocked = blocked,
        admin = admin,
        description = description;

  @override
  List<Object?> get props => [
        id,
        privateGallery,
        publicGallery,
        photo,
        userEntityName,
        email,
        blocked,
        admin,
        description,
      ];
}
