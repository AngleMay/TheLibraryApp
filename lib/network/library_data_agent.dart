import 'package:the_library/data/vos/book_list_results_vo.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';

abstract class LibraryDataAgent {
  Future<BookListResultsVO?>? getBookList(String publishedDate);
  Future<BookListVO?>? getBookDetailsList(
      String listName, String publishedDate);
  Future<List<SearchBookVO>?>? getSearchList(String? searchVal);
}
