import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

// class BookListDao {
//   static final BookListDao _singleton = BookListDao._internal();
//
//   factory BookListDao() {
//     return _singleton;
//   }
//
//   BookListDao._internal();
//
//   void saveAllBooksList(List<BookListVO> bookList) async {
//     Map<int, BookListVO> bookListMap = Map.fromIterable(bookList,
//         key: (book) => book.listId, value: (book) => book);
//     await getBookListBox().putAll(bookListMap);
//   }
//
//   List<BookListVO> getAllBookList() {
//     return getBookListBox().values.toList();
//   }
//
//   ///Reactive Programming
//   Stream<void> getAllBookListStream() {
//     return getBookListBox().watch();
//   }
//
//   Stream<List<BookListVO>> getBookListStream() {
//     return Stream.value(this.getAllBookList().toList());
//   }
//
//   List<BookListVO> getBookList() {
//     if (this.getAllBookList() != null ) {
//       return getAllBookList().toList();
//     } else {
//       return [];
//     }
//   }
//
//   Box<BookListVO> getBookListBox() {
//     return Hive.box(BOX_NAME_BOOK_LIST);
//   }
// }

abstract class SearchBookListDao {
  void saveAllBooksList(List<BookListVO> bookList);
  List<BookListVO> getAllBookList();
  Stream<void> getAllBookListStream();
  Stream<List<BookListVO>> getBookListStream();
  List<BookListVO> getBookList();
}
