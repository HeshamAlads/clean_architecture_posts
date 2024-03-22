import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repo.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUseCase {
  final PostsRepo repo;

  UpdatePostUseCase(this.repo);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await repo.updatePost(post);
  }
}
