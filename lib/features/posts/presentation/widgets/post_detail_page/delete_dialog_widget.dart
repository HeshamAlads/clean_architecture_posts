import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are You Sure ?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No')),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddDeleteUpdatePostBloc>(context)
                  .add(DeletePostEvent(postId: postId));
            },
            child: const Text('Yes')),
      ],
    );
  }
}
