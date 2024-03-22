part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();
  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}

class SuccessMessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String successMessage;
  const SuccessMessageAddDeleteUpdatePostState({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String errMessage;
  const ErrorAddDeleteUpdatePostState({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
