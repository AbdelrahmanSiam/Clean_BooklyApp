part of 'newest_books_cubit.dart';

@immutable
sealed class NewestBooksState {}

final class NewestBooksInitialState extends NewestBooksState {}
final class NewestBooksLoadingState extends NewestBooksState {}
final class NewestBooksFailureState extends NewestBooksState {
  final String errMessage;

  NewestBooksFailureState({required this.errMessage});
}
final class NewestBooksSuccessState extends NewestBooksState {
  final List<BookEntity> books;

  NewestBooksSuccessState({required this.books});
}
