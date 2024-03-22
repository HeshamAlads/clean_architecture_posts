import 'package:equatable/equatable.dart';

// Domain Start
// Step 1
// extends Equatable to Value equality
class PostEntity extends Equatable {
  final int? id;
  final String title, body;

  const PostEntity({this.id, required this.title, required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body];
}
