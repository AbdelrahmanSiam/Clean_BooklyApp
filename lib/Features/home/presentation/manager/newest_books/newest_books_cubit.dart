import 'package:bloc/bloc.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:meta/meta.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit() : super(NewestBooksInitialState());
}
