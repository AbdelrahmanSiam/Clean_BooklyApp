import 'package:clean_arch_bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly/Features/home/data/repo/home_repo_impl.dart';
import 'package:clean_arch_bookly/core/utils/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        apiServices: getIt.get<ApiServices>(),
      ),
    ),
  );
}
