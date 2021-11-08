import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';

class SearchBloc extends ChangeNotifier {
  ///State
  List<SearchBookVO?>? searchBookList;
  bool isEmpty = true;
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  onTabSearchBar(String searchVal) {
    if (searchVal != null) {
      isEmpty = false;
    }
    libraryModel.getSearchList(searchVal)?.then((bookList) {
      searchBookList = bookList;
      if(!isDisposed){
        notifyListeners();
      }
    }).catchError((error) {
      print("error>>" + error.toString());
    });
  }

  onTabCrossIcon() {
    isEmpty = true;
    if(!isDisposed){
      notifyListeners();
    }
  }

  SearchBloc([LibraryModel? libModel]) {
    if (libModel != null) {
      libraryModel = libModel;
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
