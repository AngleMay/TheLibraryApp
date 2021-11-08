import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/utils/data.dart';

class ShelfDetailsBloc extends ChangeNotifier {
  ///state
  //bool isList = false;
  SortDatas sortData = SortDatas.SORT_BY_TITLE;
  StyleDatas styleData = StyleDatas.TWO_COLUMN_GRID;
  ShelfVO? shelf;
  List<BookVO?>? bookList;
  bool isRename = false;
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  void changeStyle(changeValue) {
    // if (changeValue == 3) {
    //   style = 1;
    // } else {
    //   style = changeValue + 1;
    // }
    // libraryModel.saveStyle(changeValue);
    styleData = StyleDatas.values[Random().nextInt(StyleDatas.values.length)];
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void changeSortType(SortDatas sort) {
    // libraryModel.saveSortType(index);
    // libraryModel.getSortTypeFromDatabase().then((index) {
    //   this.sortTypeIndex = index;
    //   notifyListeners();
    // });
    sortData = SortDatas.values[Random().nextInt(SortDatas.values.length)];
    if (!isDisposed) {
      notifyListeners();
    }

    switch (sort) {
      case (SortDatas.SORT_BY_TITLE):
        bookList?.sort((a, b) {
          return (a?.title ?? "").compareTo(b?.title ?? "");
        });
        if (!isDisposed) {
          notifyListeners();
        }
        break;
      case (SortDatas.SORT_BY_AUTHOR):
        bookList?.sort((a, b) {
          return (a?.author ?? "").compareTo(b?.author ?? "");
        });
        if (!isDisposed) {
          notifyListeners();
        }
        break;
      case (SortDatas.SORT_BY_RECENT):
        bookList?.sort((a, b) {
          return (a?.createdDate ?? "").compareTo(b?.createdDate ?? "");
        });
        if (!isDisposed) {
          notifyListeners();
        }
        break;
    }
  }

  void onTabRename() {
    isRename = true;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void deleteShelf(ShelfVO? shelf) {
    libraryModel.deleteShelf(shelf);
  }

  onTabRenameShelf(ShelfVO? shelf) {
    libraryModel.saveShelf(shelf);
    isRename = false;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  ShelfDetailsBloc(
      {List<BookVO?>? books, ShelfVO? shelf1, LibraryModel? libModel}) {
    if (libModel != null) {
      libraryModel = libModel;
    }

    bookList = books;
    if (!isDisposed) {
      notifyListeners();
    }
    if (shelf1 != null) {
      shelf = shelf1;
      if (!isDisposed) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
