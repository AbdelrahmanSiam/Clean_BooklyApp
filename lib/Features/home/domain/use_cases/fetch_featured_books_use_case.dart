import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/repos/home_repo.dart';
import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:clean_arch_bookly/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase <List<BookEntity>,int>{
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase({required this.homeRepo});
  
  @override
  Future<Either<Failure, List<BookEntity>>> call([int pageNumber = 0]) {
    return homeRepo.fetchFeaturedBooks(pageNumber: pageNumber);
  }
 
}