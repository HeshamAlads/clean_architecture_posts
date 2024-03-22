import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostsRepo repo;

  GetAllPostsUseCase(this.repo);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await repo.getAllPosts();
  }
}
