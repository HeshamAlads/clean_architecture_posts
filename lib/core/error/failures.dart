import 'package:equatable/equatable.dart';
// Step 3 after Domain Repo

// extends Equatable to Value equality
abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCashFailure extends Failure {
  @override
  List<Object?> get props => [];
}
