import 'package:clean_arch_bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly/Features/home/data/repo/home_repo_impl.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:clean_arch_bookly/Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:clean_arch_bookly/Features/home/presentation/manager/featured_books/featured_books_cubit.dart';
import 'package:clean_arch_bookly/Features/home/presentation/manager/newest_books/newest_books_cubit.dart';
import 'package:clean_arch_bookly/constants.dart';
import 'package:clean_arch_bookly/core/utils/api_services.dart';
import 'package:clean_arch_bookly/core/utils/app_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return FeaturedBooksCubit(
              FetchFeaturedBooksUseCase(
                homeRepo: HomeRepoImpl(
                  homeLocalDataSource: HomeLocalDataSourceImpl(),
                  homeRemoteDataSource: HomeRemoteDataSourceImpl(
                    apiServices: ApiServices(Dio()),
                  ),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return NewestBooksCubit(
              FetchNewestBooksUseCase(
                homeRepo: HomeRepoImpl(
                  homeLocalDataSource: HomeLocalDataSourceImpl(),
                  homeRemoteDataSource: HomeRemoteDataSourceImpl(
                    apiServices: ApiServices(Dio()),
                  ),
                ),
              ),
            );
          },
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
      ),
    );
  }
}
