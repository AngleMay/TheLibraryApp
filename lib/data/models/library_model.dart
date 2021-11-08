import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';

abstract class LibraryModel {
  ///Network
  //String getTodayData();
  void getBookList();
  void getBookDetailsList(String listName);
  Future<List<SearchBookVO>?>? getSearchList(String? searchVal);

  ///Database


  //Future<int> getSortTypeFromDatabase();
  Stream<List<BookListVO>> getBookListFromDatabase();
  Stream<List<BookVO>> getBookDetailsListFromDatabase(String? listName);
  Stream<List<BookVO>> getStorageBookListFromDatabase();
  void saveBookToStorage(BookVO? book);
  // void saveSortBooks(List<BookVO> bookList);
  void saveShelf(ShelfVO? shelf);
  void deleteShelf(ShelfVO? shelf);
  Stream<List<ShelfVO>> getShelfListFromDatabase();
  void deleteBookFromLibrary(BookVO? book);
  Stream<BookVO?> getBookFromStorage(String bookId);
  List<ShelfVO?>? getShelfDetailsListForTest();

}
