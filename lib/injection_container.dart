import 'package:clean_architecture_posts/core/network/network_info.dart';
import 'package:clean_architecture_posts/features/posts/data/data_sources/local_post_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/data_sources/remote_posts_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/repositories/posts_repo_impl.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repo.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/add_post.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/delete_posts.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:clean_architecture_posts/features/posts/domain/use_cases/update_posts.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';  
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  /// Features : Posts
  // Bloc
  getIt.registerFactory(() => PostsBloc(getAllPosts: getIt()));
  getIt.registerFactory(() => AddDeleteUpdatePostBloc(
        addPost: getIt(),
        deletePost: getIt(),
        updatePost: getIt(),
      ));

  // UseCases
  getIt.registerLazySingleton(() => GetAllPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddPostUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePostUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdatePostUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<PostsRepo>(() => PostsRepoImpl(
        remotePostsDataSource: getIt(),
        localPostsDataSource: getIt(),
        networkInfo: getIt(),
      ));

  // DataSources
  getIt.registerLazySingleton<RemotePostsDataSource>(
      () => RemotePostsDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<LocalPostsDataSource>(
      () => LocalPostsDataSourceImpl(sharedPreferences: getIt()));

  /// Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  /// External Packages
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
