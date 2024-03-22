import 'package:clean_architecture_posts/core/app_theme.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (context) => di.getIt<AddDeleteUpdatePostBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: appTheme,
        title: 'Posts App',
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostsPage();
  }
}
