import 'package:flutter/cupertino.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';

class HomeBloc extends ChangeNotifier {
  ///state
  List<BookListVO?>? bookList;
  List<BookVO?>? readBookList;
  bool isDisposed = false;

  ///Model
  LibraryModel libraryModel = LibraryModelImpl();

  deleteBookFromLibrary(BookVO? book) {
    libraryModel.deleteBookFromLibrary(book);
  }

  //constructor
  HomeBloc([LibraryModel? libModel]) {
    if (libModel != null) {
      libraryModel = libModel;
    }

    ///NowPlaying Movie From Database
    // mMovieModel.getNowPlayingMoviesFromDatabase().listen((nowPlayingMovie) {
    //   mNowPlayingMovieList = nowPlayingMovie;
    //   notifyListeners();
    // }).onError((error) {});

    ///book list
    libraryModel.getBookListFromDatabase().listen((books) {
      bookList = books;
      if (!isDisposed) {
        notifyListeners();
      }
      notifyListeners();
    }).onError((error) {
      print(error);
    });

    //book list from storage
    libraryModel.getStorageBookListFromDatabase().listen((books) {
      readBookList = books;
      if (!isDisposed) {
        notifyListeners();
      }
      //notifyListeners();
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
