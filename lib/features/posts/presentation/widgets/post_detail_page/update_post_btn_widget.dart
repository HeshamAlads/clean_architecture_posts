import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:flutter/material.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final PostEntity post;

  const UpdatePostBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PostAddUpdatePage(isUpdatePost: true, post: post),
            ));
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit'),
    );
  }
}
