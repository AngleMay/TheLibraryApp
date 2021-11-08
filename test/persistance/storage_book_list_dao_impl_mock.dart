import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/storage_book_list_dao.dart';

import '../mock_data/mock_data.dart';

class StorageBookListDaoImplMock extends StorageBookListDao {
  Map<String?, BookVO> readBookListInDatabase = {};

  @override
  void deleteBookFromLibrary(BookVO? book) {
    readBookListInDatabase.remove(book?.primaryIsbn10);
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getAllStorageBookList() {
    if (getStorageBookList().isNotEmpty) {
      return getStorageBookList();
    } else {
      return [];
    }
  }

  @override
  List<BookVO> getStorageBookList() {
    return getMockReadBooks();
  }

  @override
  Stream<List<BookVO>> getStorageBookListStream() {
    return Stream.value(getMockReadBooks());
  }

  @override
  void saveBookToStorage(BookVO book) {
    readBookListInDatabase[book?.primaryIsbn10] = book;
  }
}
