import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

// class BookListByNameDao {
//   static final BookListByNameDao _singleton = BookListByNameDao._internal();
//
//   factory BookListByNameDao() {
//     return _singleton;
//   }
//   BookListByNameDao._internal();
//
//   List<BookVO> getBookDetailsList() {
//     return getBookDetailsListBox().values.toList();
//   }
//
//   void saveBookDetailsList(List<BookVO> bookList) async {
//     // Map<int, BookVO> snackMap = Map.fromIterable(snackList,
//     //     key: (snack) => bookList.id, value: (snack) => snack);
//     // await getBookDetailsListBox().putAll(snackMap);
//     Map<String, BookVO> bookMap = Map.fromIterable(bookList,
//         key: (books) => books.primaryIsbn10, value: (books) => books);
//     await getBookDetailsListBox().putAll(bookMap);
//   }
//
//   BookVO? getBookFromStorage(String bookId){
//     return getBookDetailsListBox().get(bookId);
//   }
//
//
//   List<BookVO> getAllBookDetailsList() {
//     if (this.getBookDetailsList() != null) {
//       return getBookDetailsList().toList();
//     } else {
//       return [];
//     }
//   }
//
//   //Reactive Programming
//   Stream<void> getAllBookDetailsListEventStream() {
//     return getBookDetailsListBox().watch();
//   }
//
//   Stream<List<BookVO>> getBookDetailsListStream() {
//     return Stream.value(getBookDetailsList());
//   }
//
//   Box<BookVO> getBookDetailsListBox() {
//     return Hive.box<BookVO>(BOX_NAME_BOOK_DETAILS_LIST);
//   }
// }

abstract class BookListByNameDao{
  List<BookVO> getBookDetailsList();
  void saveBookDetailsList(List<BookVO> bookList);
  BookVO? getBookFromStorage(String bookId);
  List<BookVO> getAllBookDetailsList();
  Stream<void> getAllBookDetailsListEventStream();
  Stream<List<BookVO>> getBookDetailsListStream();

}
