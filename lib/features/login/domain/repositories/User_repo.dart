import 'package:flutter/material.dart';
import 'package:inbridge/core/ressources/data_state.dart';
import 'package:inbridge/features/login/domain/entities/User.dart';
import 'package:inbridge/test/Models/User.dart';

abstract class ArticleRepository {
  // API methods
  Future<DataState<List<UserEntity>>> getNewsArticles();

  // Database methods
  // Future<List<UserEntity>> getSavedArticles();

  //Future<void> saveArticle(UserEntity article);

  // Future<void> removeArticle(UserEntity article);

  Future<UserEntity> fetchUser();
}
