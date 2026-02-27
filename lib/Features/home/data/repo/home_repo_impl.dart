import 'package:clean_arch_bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({
    required this.homeLocalDataSource,
    required this.homeRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      List<BookEntity> localBooks = homeLocalDataSource.fetchFeaturedBooks();
      if (localBooks.isNotEmpty) {
        return right(localBooks);
      }
      List<BookEntity> remoteBooks = await homeRemoteDataSource
          .fetchFeaturedBooks();
      return right(remoteBooks);
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      List<BookEntity> localBooks = homeLocalDataSource.fetchNewestBooks();
      if (localBooks.isNotEmpty) {
        return right(localBooks);
      }
      List<BookEntity> remoteBooks = await homeRemoteDataSource
          .fetchNewestBooks();
      return right(remoteBooks);
    } catch (e) {
      return left(Failure());
    }
  }
}
