import 'package:clean_arch_bookly/Features/home/domain/entites/book_entity.dart';
import 'package:hive/hive.dart';

void saveBooksToHive(List<BookEntity> booksList, String boxName) {
  var box = Hive.box(boxName);
  box.addAll(booksList);
}
