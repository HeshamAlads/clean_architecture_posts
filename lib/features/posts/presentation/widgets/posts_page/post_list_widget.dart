import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/pages/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListWidget extends StatelessWidget {
  final List<PostEntity> posts;

  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
                leading: Text(
                  posts[index].id.toString(),
                ),
                title: Text(
                  posts[index].title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  posts[index].body,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(post: posts[index]),
                    ),
                  );
                },
              ),
          separatorBuilder: (context, index) => const Divider(thickness: 1),
          itemCount: posts.length),
    );
  }

  Future _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
