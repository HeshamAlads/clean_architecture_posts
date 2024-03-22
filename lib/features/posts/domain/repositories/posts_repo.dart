import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';
// Step 2

// Call Api From Abstract Repo With Either(dartz)
abstract class PostsRepo {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> addPost(PostEntity post);
}
