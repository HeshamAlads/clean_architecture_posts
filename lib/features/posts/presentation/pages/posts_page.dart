import 'package:clean_architecture_posts/core/utils/show_toast_messages.dart';
import 'package:clean_architecture_posts/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widgets/posts_page/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Posts'));

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is SuccessPostsState) {
              return PostListWidget(posts: state.posts);
            } else if (state is ErrorPostsState) {
              showToastMessage(message: state.errMessage, color: Colors.red);
              // MessageDisplayWidget(message: state.errMessage);
            }
            return const LoadingWidget();
          },
        ),
      );

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
