import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/network/library_data_agent.dart';
import 'package:the_library/network/retrofit_data_agent_impl.dart';
import 'package:the_library/persistence/daos/book_list_by_name.dart';
import 'package:the_library/persistence/daos/impls/book_list_by_name_dao_impl.dart';
import 'package:the_library/persistence/daos/impls/search_book_list_dao_impl.dart';
import 'package:the_library/persistence/daos/impls/shelf_dao_impl.dart';
import 'package:the_library/persistence/daos/impls/storage_book_list_dao_impl.dart';
import 'package:the_library/persistence/daos/search_book_list_dao.dart';
import 'package:the_library/persistence/daos/chang_style_dao.dart';
import 'package:the_library/persistence/daos/shelf_dao.dart';
import 'package:the_library/persistence/daos/sort_type_dao.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:intl/intl.dart';
import 'package:the_library/persistence/daos/storage_book_list_dao.dart';

class LibraryModelImpl extends LibraryModel {
  static final LibraryModelImpl _singleton = LibraryModelImpl._internal();

  factory LibraryModelImpl() {
    return _singleton;
  }

  LibraryModelImpl._internal() {}

  LibraryDataAgent lDataAgent = new RetrofitDataAgentImpl();

  ///Dao

  SearchBookListDao bBookListDao = new SearchBookListDaoImpl();
  BookListByNameDao bBookListByName = new BookListByNameDaoImpl();
  StorageBookListDao storageBookListDao = new StorageBookListDaoImpl();
  ShelfDao shelfDao = new ShelfDaoImpl();

  ///For Testing
  void setDaosAndDataAgents(
      SearchBookListDao bListDao,
      BookListByNameDao bListByNameDao,
      StorageBookListDao bStorageBookListDao,
      ShelfDao sShelfDao) {
    bBookListDao = bListDao;
    bBookListByName = bListByNameDao;
    storageBookListDao = bStorageBookListDao;
    shelfDao = sShelfDao;
  }

  @override
  String getTodayData() {
    // var date = new DateTime.now().toString();
    // var dateParse = DateTime.parse(date);
    // var formattedData = "${dateParse.year}-${dateParse.month}-${dateParse.day}";
    // return formattedData;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    print(formatted);
    return formatted;
  }

  ///Network
  @override
  void getBookList() async {
    String publishedDate = getTodayData();
    Future.value(lDataAgent.getBookList(publishedDate)?.then((bookListResult) {
      bBookListDao.saveAllBooksList(bookListResult?.lists ?? []);
    }));
  }

  @override
  void getBookDetailsList(String listName) async {
    String publishedDate = getTodayData();
    lDataAgent.getBookDetailsList(listName, publishedDate)?.then((bookList) {
      bBookListByName.saveBookDetailsList(bookList?.books ?? []);
    }).catchError((error) {
      debugPrint("book list error>>" + error.toString());
    });
  }

  @override
  Future<List<SearchBookVO>?>? getSearchList(String? searchVal) {
    return lDataAgent.getSearchList(searchVal)?.then((dataList) {
      return Future.value(dataList ?? []);
    });
  }

  ///Database

  @override
  Stream<List<BookListVO>> getBookListFromDatabase() {
    this.getBookList();
    return bBookListDao
        .getAllBookListStream()
        .startWith(bBookListDao.getBookListStream())
        .map((event) => bBookListDao.getBookList());
  }

  @override
  Stream<List<BookVO>> getBookDetailsListFromDatabase(String? listName) {
    this.getBookDetailsList(listName ?? "");
    return bBookListByName
        .getAllBookDetailsListEventStream()
        .startWith(bBookListByName.getBookDetailsListStream())
        .map((event) => bBookListByName.getAllBookDetailsList());
  }

  @override
  Stream<List<BookVO>> getStorageBookListFromDatabase() {
    return storageBookListDao
        .getAllMoviesEventStream()
        .startWith(storageBookListDao.getStorageBookListStream())
        .map((event) => storageBookListDao.getAllStorageBookList());
  }

  @override
  void saveBookToStorage(BookVO? book) {
    if (book != null) {
      storageBookListDao.saveBookToStorage(book);
    }
  }

  // @override
  // void saveSortBooks(List<BookVO> bookList) {
  //   storageBookListDao.saveSortBooks(bookList);
  // }

  @override
  Stream<List<ShelfVO>> getShelfListFromDatabase() {
    return shelfDao
        .getShelfListEventStream()
        .startWith(shelfDao.getShelfListStream())
        .map((event) => shelfDao.getAllShelfList());
  }

  @override
  void saveShelf(ShelfVO? shelf) {
    shelfDao.saveShelf(shelf);
  }

  @override
  void deleteShelf(ShelfVO? shelf) {
    shelfDao.deleteShelf(shelf);
  }

  @override
  void deleteBookFromLibrary(BookVO? book) {
    storageBookListDao.deleteBookFromLibrary(book);
  }

  @override
  Stream<BookVO?> getBookFromStorage(String bookId) {
    return Stream.value(bBookListByName.getBookFromStorage(bookId));
  }
  List<ShelfVO?>? getShelfDetailsListForTest() {
    return shelfDao.getShelfDetailsListForTest();
  }
}
