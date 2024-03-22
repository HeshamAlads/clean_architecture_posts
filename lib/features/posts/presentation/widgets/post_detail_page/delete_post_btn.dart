import 'package:clean_architecture_posts/core/utils/show_toast_messages.dart';
import 'package:clean_architecture_posts/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;

  const DeletePostBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline_outlined),
      label: const Text('Delete'),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is SuccessMessageAddDeleteUpdatePostState) {
              showToastMessage(
                  message: state.successMessage, color: Colors.green);
              // SnackBarMessage().showSuccessSnackBar(
              //     message: state.successMessage, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const PostsPage(),
                  ),
                      (route) => false);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              Navigator.of(context).pop();

              showToastMessage(message: state.errMessage, color: Colors.red);
              // SnackBarMessage().showErrorSnackBar(
              //     message: state.errMessage, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }
}
