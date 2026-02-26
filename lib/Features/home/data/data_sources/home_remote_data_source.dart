import 'package:clean_arch_bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:clean_arch_bookly/core/utils/api_services.dart';

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
    return booksList;
  }

  List<BookEntity> parseBooks(Map<String, dynamic> data) {
    List<BookEntity> booksList = [];
    for (var bookItem in data["items"]) {
      booksList.add(BookModel.fromBookJson(bookItem));
    }
    return booksList;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() {
    // TODO: implement fetchNewestBooks
    throw UnimplementedError();
  }
}
