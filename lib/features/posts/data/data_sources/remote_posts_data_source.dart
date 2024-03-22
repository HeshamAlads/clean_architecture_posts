import 'dart:async';
import 'dart:convert';

import 'package:clean_architecture_posts/core/error/exceptions.dart';
import 'package:clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemotePostsDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePosts(int postId);

  Future<Unit> updatePosts(PostModel postModel);

  Future<Unit> addPosts(PostModel postModel);
}

const baseUrl = 'https://jsonplaceholder.typicode.com';

class RemotePostsDataSourceImpl implements RemotePostsDataSource {
  final http.Client client;

  RemotePostsDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse('$baseUrl/posts/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPosts(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final response = await client.post(
      Uri.parse('$baseUrl/posts/'),
      body: body,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePosts(int postId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/posts/${postId.toString()}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    throw ServerException();
  }

  @override
  Future<Unit> updatePosts(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final response = await client.patch(
      Uri.parse("$baseUrl/posts/${postId.toString()}"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
