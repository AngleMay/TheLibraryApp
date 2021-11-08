import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
import 'package:the_library/persistence/daos/search_book_list_dao.dart';

class SearchBookListDaoImpl extends SearchBookListDao {
  static final SearchBookListDaoImpl _singleton =
      SearchBookListDaoImpl._internal();

  factory SearchBookListDaoImpl() {
    return _singleton;
  }

  SearchBookListDaoImpl._internal();

  @override
  void saveAllBooksList(List<BookListVO> bookList) async {
    Map<int, BookListVO> bookListMap = Map.fromIterable(bookList,
        key: (book) => book.listId, value: (book) => book);
    await getBookListBox().putAll(bookListMap);
  }

  @override
  List<BookListVO> getAllBookList() {
    return getBookListBox().values.toList();
  }

  @override
  ///Reactive Programming
  Stream<void> getAllBookListStream() {
    return getBookListBox().watch();
  }

  @override
  Stream<List<BookListVO>> getBookListStream() {
    return Stream.value(this.getAllBookList().toList());
  }

  @override
  List<BookListVO> getBookList() {
    if (this.getAllBookList() != null) {
      return getAllBookList().toList();
    } else {
      return [];
    }
  }

  @override
  Box<BookListVO> getBookListBox() {
    return Hive.box(BOX_NAME_BOOK_LIST);
  }
}
