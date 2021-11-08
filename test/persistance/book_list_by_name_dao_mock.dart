import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/book_list_by_name.dart';

import '../mock_data/mock_data.dart';

class BookListByNameDaoMock extends BookListByNameDao {
  Map<String?, BookVO> BookListInDatabaseMock = {};

  @override
  List<BookVO> getAllBookDetailsList() {
    if (getBookDetailsList().isNotEmpty) {
      return getBookDetailsList();
    } else {
      return [];
    }
  }

  @override
  Stream<void> getAllBookDetailsListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getBookDetailsList() {
    return getMockBooksByListName();
  }

  @override
  Stream<List<BookVO>> getBookDetailsListStream() {
    return Stream.value(getMockBooksByListName());
  }

  @override
  BookVO? getBookFromStorage(String bookId) {
    return getMockBooksByListName().first;
  }

  @override
  void saveBookDetailsList(List<BookVO> bookList) {
    bookList.forEach((book) {
      BookListInDatabaseMock[book.primaryIsbn10] = book;
    });
  }
}
