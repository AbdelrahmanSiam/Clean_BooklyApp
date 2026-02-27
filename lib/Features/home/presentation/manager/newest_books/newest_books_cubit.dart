import 'package:bloc/bloc.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:clean_arch_bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.fetchNewestBooksUseCase)
    : super(NewestBooksInitialState());
  final FetchNewestBooksUseCase fetchNewestBooksUseCase;
  Future<void> fetchNewestBooks() async {
    emit(NewestBooksLoadingState());
    Either<Failure, List<BookEntity>> result = await fetchNewestBooksUseCase
        .call();
    result.fold(
      (error) {
        emit(NewestBooksFailureState(errMessage: error.errMessage));
      },
      (books) {
        emit(NewestBooksSuccessState(books: books));
      },
    );
  }
}
