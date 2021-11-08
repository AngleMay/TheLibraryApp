import 'package:the_library/data/vos/book_list_results_vo.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/network/library_data_agent.dart';

import '../mock_data/mock_data.dart';

class LibraryDataAgentImplMock extends LibraryDataAgent {

  @override
  Future<BookListVO?>? getBookDetailsList(
      String listName, String publishedDate) {
    return Future.value(getMockBookDetailsList().first);
  }

  @override
  Future<BookListResultsVO?>? getBookList(String publishedDate) {
    return Future.value(getMockBookList());
  }

  @override
  Future<List<SearchBookVO>?>? getSearchList(String? searchVal) {
    return Future.value(getMockSearchBooksList());
  }
}
