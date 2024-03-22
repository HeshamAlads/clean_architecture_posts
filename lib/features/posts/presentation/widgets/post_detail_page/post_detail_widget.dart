import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widgets/post_detail_page/delete_post_btn.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widgets/post_detail_page/update_post_btn_widget.dart';
import 'package:flutter/material.dart';

class PostDetailWidget extends StatelessWidget {
  final PostEntity post;

  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
            thickness: 1,
          ),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!),
            ],
          ),
        ],
      ),
    );
  }
}
