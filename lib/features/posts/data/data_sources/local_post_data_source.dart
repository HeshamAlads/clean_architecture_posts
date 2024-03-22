import 'dart:async';
import 'dart:convert';

import 'package:clean_architecture_posts/core/error/exceptions.dart';
import 'package:clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalPostsDataSource {
  Future<List<PostModel>> getCashedPosts();

  Future<Unit> cashPosts(List<PostModel> postModels);
}

class LocalPostsDataSourceImpl implements LocalPostsDataSource {
  final SharedPreferences sharedPreferences;

  LocalPostsDataSourceImpl({required this.sharedPreferences});

  static const cashedPosts = 'CASHED_POSTS';

  @override
  Future<Unit> cashPosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString(cashedPosts, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final jsonString = sharedPreferences.getString(cashedPosts);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCashException();
    }
  }
}
