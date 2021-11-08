import 'package:flutter/material.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';

class BookDetailsListBloc extends ChangeNotifier {
  ///State
  List<BookVO?>? bookList;
  List<SearchBookVO?>? searchBookList;
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  ///constructor
  BookDetailsListBloc(String? listName,
      {String? title, LibraryModel? libModel}) {
    if (libModel != null) {
      libraryModel = libModel;
    }
    // if (listName != "") {
    libraryModel.getBookDetailsListFromDatabase(listName).listen((books) {
      bookList = books;
      if (!isDisposed) {
        notifyListeners();
      }
    }).onError((error) {
      debugPrint("error >>" + error.toString());
    });
    // } else {
    // libraryModel.getSearchList(title)?.then((books) {
    //   searchBookList = books;
    //   bookList =
    //       searchBookList?.map((book) => book?.convertToBookVO(book)).toList();
    //   if (!isDisposed) {
    //     notifyListeners();
    //   }
    // }).catchError((error) {
    //   print("error>>" + error.toString());
    // });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
