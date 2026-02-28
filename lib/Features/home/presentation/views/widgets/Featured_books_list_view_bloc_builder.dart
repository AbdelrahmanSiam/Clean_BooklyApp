import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/Features/home/presentation/manager/featured_books/featured_books_cubit.dart';
import 'package:clean_arch_bookly/Features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksListViewBlocBuilder extends StatefulWidget {
  const FeaturedBooksListViewBlocBuilder({super.key});

  @override
  State<FeaturedBooksListViewBlocBuilder> createState() =>
      _FeaturedBooksListViewBlocConsumerState();
}

class _FeaturedBooksListViewBlocConsumerState
    extends State<FeaturedBooksListViewBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      listener: (context, state) {
        if (state is FeaturedBooksSuccessState) {
          books.addAll(state.books);
        } else if (state is FeaturedBooksPaginationFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FeaturedBooksFailureState) {
          return Center(child: Text(state.errMessage));
        } else if (state is FeaturedBooksSuccessState ||
            state is FeaturedBooksPaginationLoadingState ||
            state is FeaturedBooksPaginationFailureState) {
          return FeaturedBooksListView(books: books);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
