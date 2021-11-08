import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
//
// class StorageBookListDao {
//   static final StorageBookListDao _singleton = StorageBookListDao._internal();
//
//   factory StorageBookListDao() {
//     return _singleton;
//   }
//
//   StorageBookListDao._internal();
//
//   List<BookVO?>? bookList;
//
//   //Reactive Programming
//   Stream<void> getAllMoviesEventStream() {
//     return getStorageBookListBox().watch();
//   }
//
//   Stream<List<BookVO>> getStorageBookListStream() {
//     return Stream.value(getAllStorageBookList().toList());
//   }
//
//   // void saveBookToStorage(BookVO book) async {
//   //   //await getStorageBookListBox().put(book.primaryIsbn10,book);
//   //   bookList = this.getAllStorageBookList();
//   //   bookList.add(book);
//   //   Map<String, BookVO> booksMap = Map.fromIterable(bookList,
//   //       key: (book) => book.primaryIsbn10, value: (book) => book);
//   //   await getStorageBookListBox().putAll(booksMap);
//   // }
//
//   void saveBookToStorage(BookVO book) async {
//     await getStorageBookListBox().put(book.primaryIsbn10, book);
//   }
//
//   void saveSortBooks(List<BookVO> bookList) async {
//     Map<String, BookVO> booksMap = Map.fromIterable(bookList,
//         key: (book) => book.primaryIsbn10, value: (book) => book);
//     await getStorageBookListBox().putAll(booksMap);
//   }
//
//   List<BookVO> getStorageBookList() {
//     return getStorageBookListBox().values.toList();
//   }
//
//   List<BookVO> getAllStorageBookList() {
//     if (this.getStorageBookList() != null) {
//       return getStorageBookList().toList();
//     } else {
//       return [];
//     }
//   }
//
//   void deleteBookFromLibrary(BookVO? book) async {
//     await getStorageBookListBox().delete(book?.primaryIsbn10);
//   }
//
//   Box<BookVO> getStorageBookListBox() {
//     return Hive.box<BookVO>(BOX_NAME_STORAGE_BOOK_LIST);
//   }
// }

abstract class StorageBookListDao {
  Stream<void> getAllMoviesEventStream();
  Stream<List<BookVO>> getStorageBookListStream();
  void saveBookToStorage(BookVO book);
  //void saveSortBooks(List<BookVO> bookList);
  List<BookVO> getStorageBookList();
  List<BookVO> getAllStorageBookList();
  void deleteBookFromLibrary(BookVO? book);

}
