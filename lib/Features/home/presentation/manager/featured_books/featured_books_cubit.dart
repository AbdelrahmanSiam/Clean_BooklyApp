import 'package:bloc/bloc.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
    : super(FeaturedBooksInitialState());

  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;

  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {// to load only at first time
      emit(FeaturedBooksLoadingState());
    }
    Either<Failure, List<BookEntity>> result = await fetchFeaturedBooksUseCase
        .call(pageNumber);
    result.fold(
      (error) {
        emit(FeaturedBooksFailureState(errMessage: error.errMessage));
      },
      (books) {
        emit(FeaturedBooksSuccessState(books: books));
      },
    );
  }
}
