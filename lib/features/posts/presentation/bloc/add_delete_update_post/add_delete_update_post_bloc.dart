import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/core/strings/failure.dart';
import 'package:clean_architecture_posts/core/strings/success_messages.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/add_post.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/delete_posts.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/update_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>(
      (event, emit) async {
        if (event is AddPostEvent) {
          emit(LoadingAddDeleteUpdatePostState());
          final failureOrSuccessMessage = await addPost(event.post);
          emit(_eitherSuccessOrErrorMessageState(
              failureOrSuccessMessage, ADD_SUCCESS_MESSAGE));
        } else if (event is UpdatePostEvent) {
          emit(LoadingAddDeleteUpdatePostState());
          final failureOrSuccessMessage = await updatePost(event.post);
          emit(_eitherSuccessOrErrorMessageState(
              failureOrSuccessMessage, UPDATE_SUCCESS_MESSAGE));
        } else if (event is DeletePostEvent) {
          emit(LoadingAddDeleteUpdatePostState());
          final failureOrSuccessMessage = await deletePost(event.postId);
          emit(_eitherSuccessOrErrorMessageState(
              failureOrSuccessMessage, DELETE_SUCCESS_MESSAGE));
        }
      },
    );
  }

  AddDeleteUpdatePostState _eitherSuccessOrErrorMessageState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorAddDeleteUpdatePostState(
            errMessage: _mapFailureToMessage(failure)),
        (success) =>
            SuccessMessageAddDeleteUpdatePostState(successMessage: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'UnExpected Error, please try again later.';
    }
  }
}
