import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/book_list_by_name.dart';

import '../hive_constants.dart';

class BookListByNameDaoImpl extends BookListByNameDao {
     static final BookListByNameDaoImpl _singleton = BookListByNameDaoImpl._internal();

  factory BookListByNameDaoImpl() {
    return _singleton;
  }
     BookListByNameDaoImpl._internal();

  @override
  List<BookVO> getBookDetailsList() {
    return getBookDetailsListBox().values.toList();
  }

  @override
  void saveBookDetailsList(List<BookVO> bookList) async {
    // Map<int, BookVO> snackMap = Map.fromIterable(snackList,
    //     key: (snack) => bookList.id, value: (snack) => snack);
    // await getBookDetailsListBox().putAll(snackMap);
    Map<String, BookVO> bookMap = Map.fromIterable(bookList,
        key: (books) => books.primaryIsbn10, value: (books) => books);
    await getBookDetailsListBox().putAll(bookMap);
  }

  @override
  BookVO? getBookFromStorage(String bookId){
    return getBookDetailsListBox().get(bookId);
  }

  @override
  List<BookVO> getAllBookDetailsList() {
    if (this.getBookDetailsList() != null) {
      return getBookDetailsList().toList();
    } else {
      return [];
    }
  }

  @override
  //Reactive Programming
  Stream<void> getAllBookDetailsListEventStream() {
    return getBookDetailsListBox().watch();
  }

  @override
  Stream<List<BookVO>> getBookDetailsListStream() {
    return Stream.value(getBookDetailsList());
  }


  Box<BookVO> getBookDetailsListBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_DETAILS_LIST);
  }
}