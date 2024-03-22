import 'package:clean_architecture_posts/core/error/exceptions.dart';
import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/core/network/network_info.dart';
import 'package:clean_architecture_posts/features/posts/data/data_sources/local_post_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/data_sources/remote_posts_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repo.dart';
import 'package:dartz/dartz.dart';

typedef DeleteOrUpdateOrAdd = Future<Unit> Function();

class PostsRepoImpl implements PostsRepo {
  final RemotePostsDataSource remotePostsDataSource;
  final LocalPostsDataSource localPostsDataSource;
  final NetworkInfo networkInfo;

  PostsRepoImpl({
    required this.remotePostsDataSource,
    required this.localPostsDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remotePostsDataSource.getAllPosts();
        localPostsDataSource.cashPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localPostsDataSource.getCashedPosts();
        return Right(localPosts);
      } on EmptyCashException {
        return Left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);

    return await _getMessage(
      () async {
        return await remotePostsDataSource.addPosts(postModel);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(
      () async {
        return await remotePostsDataSource.deletePosts(postId);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return await _getMessage(
      () async {
        return await remotePostsDataSource.updatePosts(postModel);
      },
    );
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAdd deleteOrUpdateOrAdd) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAdd();
        return right(unit);
      } on ServerException {
        return Left(ServerFailure as Failure);
      }
    } else {
      return Left(OfflineFailure as Failure);
    }
  }
}
