part of 'featured_books_cubit.dart';

@immutable
sealed class FeaturedBooksState {}

final class FeaturedBooksInitialState extends FeaturedBooksState {}
final class FeaturedBooksLoadingState extends FeaturedBooksState {}
final class FeaturedBooksFailureState extends FeaturedBooksState {
  final String errMessage;

  FeaturedBooksFailureState({required this.errMessage});
}
final class FeaturedBooksSuccessState extends FeaturedBooksState {
  final List<BookEntity> books;

  FeaturedBooksSuccessState({required this.books});
}
