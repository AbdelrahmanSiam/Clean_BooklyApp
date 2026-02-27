import 'package:bloc/bloc.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit() : super(FeaturedBooksInitialState());
}
