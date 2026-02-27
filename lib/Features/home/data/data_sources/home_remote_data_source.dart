import 'package:clean_arch_bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/constants.dart';
import 'package:clean_arch_bookly/core/utils/api_services.dart';
import 'package:clean_arch_bookly/core/utils/functions/save_books_to_hive.dart';
import 'package:hive_flutter/adapters.dart';

abstract class HomeRemoteDataSource {
  // we do not use Either class her because decision if data returns or not we make it into HomeRepo data layer to fetch data only
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourceImpl({required this.apiServices});
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiServices.get(
      endPoint: "volumes?Filtering=free-ebooks&q=programming",
    );
    List<BookEntity> booksList = parseBooks(data); // for Single Responsability
    saveBooksToHive(booksList, kFeaturedBox);
    return booksList;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiServices.get(
      endPoint: "volumes?Filtering=free-ebooks&Sorting=newest&q=programming",
    );

    List<BookEntity> newestBooksList = parseBooks(data);
    saveBooksToHive(newestBooksList, kNewestBox);
    return newestBooksList;
  }

  // helper method to parse form Map<String, dynamic> to List<BookEntity>
  List<BookEntity> parseBooks(Map<String, dynamic> data) {
    List<BookEntity> booksList = [];
    for (var bookItem in data["items"]) {
      booksList.add(BookModel.fromBookJson(bookItem));
    }
    return booksList;
  }
}
