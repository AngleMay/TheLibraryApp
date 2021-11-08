import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';

class ShelfPageBloc extends ChangeNotifier {
  ///state
  List<ShelfVO?>? shelfList = [];
  List<BookVO?>? bookList = [];
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  saveBookToShelf(BookVO? book, ShelfVO? shelf) {
    shelf?.bookList?.toList();
    //shelf.bookList.add(book);
    bookList?.addAll(shelf?.bookList ?? []);
    bookList?.add(book);
    shelf?.bookList = bookList;
    libraryModel.saveShelf(shelf);
    //libraryModel.saveBooksToShelf(book, shelf);
  }

  ShelfPageBloc([LibraryModel? libModel]) {
    if (libModel != null) {
      libraryModel = libModel;
    }
    libraryModel.getShelfListFromDatabase().listen((shelfs) {
      shelfList = shelfs;
      if(!isDisposed){
        notifyListeners();
      }
    }).onError((error) {
      print(error.toString());
    });
  }

  List<ShelfVO?>? testSaveBookToShelf() {
    return libraryModel?.getShelfDetailsListForTest();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
