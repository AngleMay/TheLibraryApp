import 'package:flutter/material.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';

class SearchBookListBloc extends ChangeNotifier {
  ///State
  List<BookVO?>? bookList;
  List<SearchBookVO?>? searchBookList;
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  SearchBookListBloc(String? title) {
    libraryModel.getSearchList(title)?.then((books) {
      searchBookList = books;
      bookList =
          searchBookList?.map((book) => book?.convertToBookVO(book)).toList();
      if (!isDisposed) {
        notifyListeners();
      }
    }).catchError((error) {
      print("error>>" + error.toString());
    });
  }
}
