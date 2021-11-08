import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:uuid/uuid.dart';

class CreateShelfBloc extends ChangeNotifier {
  ///state
  //bool isList = false;
  int style = 1;
  int sortTypeIndex = 2;
  ShelfVO? shelf;
  var uuid = Uuid();
  List<BookVO?>? bookList;
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  CreateShelfBloc(ShelfVO? passShelf, [LibraryModel? libModel]) {

    if (libModel != null) {
      libraryModel = libModel;
    }

    notifyListeners();
    shelf = passShelf;
    if (passShelf != null) {
      shelf?.isEmpty = false;
      bookList = passShelf.bookList;
      if(!isDisposed){
        notifyListeners();
      }
    }
  }

  createShelf(ShelfVO shelf) {
    shelf.id = uuid.v1();
    libraryModel.saveShelf(shelf);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
