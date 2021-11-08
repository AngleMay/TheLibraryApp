import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/persistence/daos/search_book_list_dao.dart';

import '../mock_data/mock_data.dart';

class SearchBookListDaoImplMock extends SearchBookListDao {
  Map<int?, BookListVO> BookListInDatabase = {};
  @override
  List<BookListVO> getAllBookList() {
    if (getBookList().isNotEmpty) {
      return getMockBookDetailsList();
    } else {
      return [];
    }
  }

  @override
  Stream<void> getAllBookListStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookListVO> getBookList() {
    return getMockBookDetailsList();
  }

  @override
  Stream<List<BookListVO>> getBookListStream() {
    return Stream.value(getMockBookDetailsList());
  }

  @override
  void saveAllBooksList(List<BookListVO> bookList) {
    bookList.forEach((bookList) {
      BookListInDatabase[bookList.listId] = bookList;
    });
  }
}
