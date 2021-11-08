import 'package:dio/dio.dart';
import 'package:the_library/data/vos/book_details_list_vo.dart';
import 'package:the_library/data/vos/book_list_results_vo.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/network/api_constants.dart';
import 'package:the_library/network/library_data_agent.dart';
import 'package:the_library/network/search_book_api.dart';
import 'package:the_library/network/the_library_api.dart';

class RetrofitDataAgentImpl extends LibraryDataAgent {
  TheLibraryApi? lApi;
  SearchBookApi? searchApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    Dio dio = Dio();
    lApi = TheLibraryApi(dio);
    searchApi = SearchBookApi(dio);
  }

  @override
  Future<BookListResultsVO?>? getBookList(String publishedDate) {
    return lApi
        ?.getBookList(publishedDate, API_KEY)
        .asStream()
        .map((data) => data.results)
        .first;
  }

  @override
  Future<BookListVO?>? getBookDetailsList(String listName, String publishedDate) {
    return lApi
        ?.getBookDetailsList(listName, publishedDate, API_KEY)
        .asStream()
        .map((data) => data.results)
        .first;
  }

  @override
  Future<List<SearchBookVO>?>? getSearchList(String? searchVal) {
    return searchApi
        ?.getSearchBookList(searchVal)
        .asStream()
        .map((data) => data.items)
        .first;
  }
}
