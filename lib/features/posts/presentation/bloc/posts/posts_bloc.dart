import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/core/strings/failure.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(
          LoadingPostsState(),
        );
        final failureOrPosts = await getAllPosts();
        emit(
          _mapFailureOrPostsState(failureOrPosts),
        );
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(
          _mapFailureOrPostsState(failureOrPosts),
        );
      }
    });
  }

  PostsState _mapFailureOrPostsState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
      (failure) => ErrorPostsState(
        errMessage: _mapFailureToMessage(failure),
      ),
      (posts) => SuccessPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCashFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'UnExpected Error, please try again later.';
    }
  }
}
