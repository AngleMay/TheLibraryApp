import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/utils/data.dart';

class YourBooksBloc extends ChangeNotifier {
  ///state
  //bool isList = false;
  //int sortTypeIndex = 2;
  SortDatas sortData = SortDatas.SORT_BY_TITLE;
  StyleDatas styleData = StyleDatas.TWO_COLUMN_GRID;

  List<BookVO?>? readBookList;
  //int style = 2;
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
    final nextIndex = (changeValue.index + 1) % StyleDatas.values.length;
    styleData = StyleDatas.values[nextIndex];

    // if(styleData == StyleDatas.LIST_VIEW){
    //   styleData = StyleDatas.
    // }

    //styleData = StyleDatas.values[]

    if(!isDisposed){
      notifyListeners();
    }
  }

  void changeSortType(SortDatas sort) {
    // libraryModel.saveSortType(index);
    // libraryModel.getSortTypeFromDatabase().then((index) {
    //   this.sortTypeIndex = index;
    //   notifyListeners();
    // });

    final nextIndex = (sort.index + 1) % StyleDatas.values.length;
    sortData = SortDatas.values[nextIndex];
    notifyListeners();

    switch (sort) {
      case (SortDatas.SORT_BY_TITLE):
        readBookList?.sort((a, b) {
          return (a?.title ?? "").compareTo(b?.title ?? "");
        });
        notifyListeners();
        break;
      case (SortDatas.SORT_BY_AUTHOR):
        readBookList?.sort((a, b) {
          return (a?.author ?? "").compareTo(b?.author ?? "");
        });
        notifyListeners();
        break;
      case (SortDatas.SORT_BY_RECENT):
        readBookList?.sort((a, b) {
          return (a?.createdDate ?? "").compareTo(b?.createdDate ?? "");
        });
        notifyListeners();
        break;
    }
    // if (index == 1) {
    //   readBookList?.sort((a, b) {
    //     return (a?.author ?? "").compareTo(b?.author ?? "");
    //   });
    //   notifyListeners();
    // } else if (index == 2) {
    //   readBookList?.sort((a, b) {
    //     return (a?.createdDate ?? "").compareTo(b?.createdDate ?? "");
    //   });;
    //   notifyListeners()
    // } else {
    //   readBookList?.sort((a, b) {
    //     return (a?.title ?? "").compareTo(b?.title ?? "");
    //   });
    //   notifyListeners();
    // }
  }

  YourBooksBloc([LibraryModel? libModel]) {
    if (libModel != null) {
      libraryModel = libModel;
    }

    //changeStyle();

    //book list from storage
    libraryModel.getStorageBookListFromDatabase().listen((books) {
      readBookList = books;
      if(!isDisposed){
        notifyListeners();
      }
    }).onError((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
