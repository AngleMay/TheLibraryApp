import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
import 'package:the_library/persistence/daos/storage_book_list_dao.dart';

class StorageBookListDaoImpl extends StorageBookListDao {
  static final StorageBookListDaoImpl _singleton =
      StorageBookListDaoImpl._internal();

  factory StorageBookListDaoImpl() {
    return _singleton;
  }

  StorageBookListDaoImpl._internal();

  List<BookVO?>? bookList;

  @override
  //Reactive Programming
  Stream<void> getAllMoviesEventStream() {
    return getStorageBookListBox().watch();
  }

  @override
  Stream<List<BookVO>> getStorageBookListStream() {
    return Stream.value(getAllStorageBookList().toList());
  }

  @override
  void saveBookToStorage(BookVO book) async {
    await getStorageBookListBox().put(book.primaryIsbn10, book);
  }

  @override
  void saveSortBooks(List<BookVO> bookList) async {
    Map<String, BookVO> booksMap = Map.fromIterable(bookList,
        key: (book) => book.primaryIsbn10, value: (book) => book);
    await getStorageBookListBox().putAll(booksMap);
  }

  @override
  List<BookVO> getStorageBookList() {
    return getStorageBookListBox().values.toList();
  }

  @override
  List<BookVO> getAllStorageBookList() {
    if (this.getStorageBookList() != null) {
      return getStorageBookList().toList();
    } else {
      return [];
    }
  }

  @override
  void deleteBookFromLibrary(BookVO? book) async {
    await getStorageBookListBox().delete(book?.primaryIsbn10);
  }

  Box<BookVO> getStorageBookListBox() {
    return Hive.box<BookVO>(BOX_NAME_STORAGE_BOOK_LIST);
  }
}
