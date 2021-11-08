import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/persistence/daos/book_list_by_name.dart';
import 'package:the_library/persistence/daos/search_book_list_dao.dart';
import 'package:the_library/persistence/daos/shelf_dao.dart';
import 'package:the_library/persistence/daos/storage_book_list_dao.dart';

import '../../mock_data/mock_data.dart';
import '../../persistance/book_list_by_name_dao_mock.dart';
import '../../persistance/search_book_list_dao_impl_mock.dart';
import '../../persistance/shelf_dao_impl_mock.dart';
import '../../persistance/storage_book_list_dao_impl_mock.dart';

class LibraryModelImplMock extends LibraryModel {
  ShelfDao shelfDao = ShelfDaoImplMock();
  StorageBookListDao bookDao = StorageBookListDaoImplMock();
  BookListByNameDao bookListByName = BookListByNameDaoMock();
  SearchBookListDao searchBookListDao = SearchBookListDaoImplMock();

  ///For Testing
  void setDaosAndDataAgents(
      SearchBookListDao bListDao,
      BookListByNameDao bListByNameDao,
      StorageBookListDao bStorageBookListDao,
      ShelfDao sShelfDao) {
    searchBookListDao = bListDao;
    bookListByName = bListByNameDao;
    bookDao = bStorageBookListDao;
    shelfDao = sShelfDao;
  }

  @override
  void deleteBookFromLibrary(BookVO? book) {
    bookDao.deleteBookFromLibrary(book);
  }

  @override
  void deleteShelf(ShelfVO? shelf) {
    shelfDao.deleteShelf(shelf);
  }

  @override
  void getBookDetailsList(String listName) {
    //no need to mock
  }

  @override
  Stream<List<BookVO>> getBookDetailsListFromDatabase(String? listName) {
    return Stream.value(getMockBooksByListName());
  }

  @override
  Stream<BookVO?> getBookFromStorage(String bookId) {
    // return Stream.value(
    //     getMockReadBooks().where((book) => book.primaryIsbn10 == bookId).first);
    return Stream.value(getMockReadBooks().first);
  }

  @override
  void getBookList() {
    //no need to mock
  }

  @override
  Stream<List<BookListVO>> getBookListFromDatabase() {
    return Stream.value(getMockBookDetailsList());
  }

  @override
  Future<List<SearchBookVO>?>? getSearchList(String? searchVal) {
    return Future.value(getMockSearchBooksList());
  }

  @override
  Stream<List<ShelfVO>> getShelfListFromDatabase() {
    return Stream.value(getMockShelves());
  }

  @override
  void saveBookToStorage(BookVO? book) {
    if (book != null) {
      bookDao.saveBookToStorage(book);
    }
  }

  @override
  void saveShelf(ShelfVO? shelf) {
    shelfDao.saveShelf(shelf);
  }

  // @override
  // List<ShelfVO>? testSaveAndDeleteShelf() {
  //   return shelfDao.getShelfList();
  //   return shelfDao.getShelfList();
  // }

  @override
  Stream<List<BookVO>> getStorageBookListFromDatabase() {
    return Stream.value(getMockReadBooks());
  }

  List<ShelfVO?>? getShelfDetailsListForTest() {
   return shelfDao.getShelfDetailsListForTest();
  }
}
