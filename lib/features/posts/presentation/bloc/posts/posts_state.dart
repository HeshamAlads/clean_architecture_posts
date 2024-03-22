part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class SuccessPostsState extends PostsState {
  final List<PostEntity> posts;

  const SuccessPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String errMessage;

  const ErrorPostsState({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}
