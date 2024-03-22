import 'package:clean_architecture_posts/core/utils/show_toast_messages.dart';
import 'package:clean_architecture_posts/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widgets/post_add_update_page/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }
            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
          listener: (context, state) {
            if (state is SuccessMessageAddDeleteUpdatePostState) {
              showToastMessage(
                  message: state.successMessage, color: Colors.green);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const PostsPage(),
                ),
              );
            } else if (state is ErrorAddDeleteUpdatePostState) {
              showToastMessage(message: state.errMessage, color: Colors.red);
            }
          },
        ),
      ),
    );
  }
}
