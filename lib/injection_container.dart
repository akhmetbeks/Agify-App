import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/agify/data/datasource/agify_remote_data_source.dart';
import 'package:clean_arch/features/agify/data/repositories/agify_repo_impl.dart';
import 'package:clean_arch/features/agify/presentation/bloc/agify_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/agify/data/datasource/agify_local_data_source.dart';
import 'features/agify/domain/repositories/agify_repo.dart';
import 'features/agify/domain/usecases/get_agify_by_name.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //Bloc
  sl.registerFactory(() => AgifyBloc(getAgifyByName: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetAgifyByName(sl()));

  //Repository
  sl.registerLazySingleton<AgifyRepo>(
    () => AgifyRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<AgifyRemoteDataSource>(
      () => AgifyRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<AgifyLocalDataSource>(
      () => AgifyLocalDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! Extrenal
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
