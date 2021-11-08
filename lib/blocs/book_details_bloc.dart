import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';

class BookDetailsBloc extends ChangeNotifier {
  ///State
  List<BookVO>? similarBook;
  BookVO? book;
  bool isDisposed = false;

  ///Model
  LibraryModel? libraryModel = LibraryModelImpl();

  ///constructor
  BookDetailsBloc(String? listName, BookVO? books,
      {SearchBookVO? searchBook, LibraryModel? libModel}) {
    if (libModel != null) {
      libraryModel = libModel;
    }
    if (listName != null && listName != "") {
      book = books;
      if (!isDisposed) {
        notifyListeners();
      }
      libraryModel?.getBookDetailsListFromDatabase(listName).listen((books) {
        similarBook = books;
        if (!isDisposed) {
          notifyListeners();
        }
      }).onError((error) {
        debugPrint("error >>" + error.toString());
      });
    } else {
      this.book = searchBook?.convertToBookVO(searchBook);
      debugPrint("bookId >> $book");
      if (!isDisposed) {
        notifyListeners();
      }
    }
    if (book != null) {
      libraryModel?.saveBookToStorage(book);
    }

  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
