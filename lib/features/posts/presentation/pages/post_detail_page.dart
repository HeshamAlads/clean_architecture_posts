import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widgets/post_detail_page/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final PostEntity post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }


  // Methods
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Post Detail'),
    );
  }

  Center _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }

}


