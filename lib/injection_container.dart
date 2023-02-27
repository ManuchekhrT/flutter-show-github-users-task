import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:show_github_users/commons/network/network_info.dart';
import 'package:show_github_users/data/datasources/user_list_datasource.dart';
import 'package:show_github_users/data/repositories/user_list_repository_impl.dart';
import 'package:show_github_users/domain/repositories/user_list_repository.dart';
import 'package:show_github_users/domain/usecases/fetch_users_usecase.dart';
import 'package:show_github_users/network/user_list_datasource_impl.dart';
import 'package:show_github_users/presentation/user_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * Presenter Layer
  // to BLOC version
  sl.registerFactory(
        () => UserListCubit(fetchUsersUseCase: sl()),
  );

  // * Domain Layer
  sl.registerFactory(() => FetchUsersUseCase(repository: sl()));

  // * Data Layer
  sl.registerLazySingleton<UserListRepository>(
          () => UserListRepositoryImpl(
          networkInfo: sl(),
          userListDatasource: sl()
          )
  );

  // * Network Layer
  sl.registerFactory<UserListDatasource>(
          () => UserListDatasourceImpl(client: sl()));

  // * Commons
  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // * External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
