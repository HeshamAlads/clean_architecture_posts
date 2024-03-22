import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repo.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepo repo;

  DeletePostUseCase(this.repo);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repo.deletePost(postId);
  }
}
