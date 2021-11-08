import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_library/network/api_constants.dart';
import 'package:the_library/network/responses/search_books_response.dart';
part 'search_book_api.g.dart';

@RestApi(baseUrl: BASE_URL_FOR_SEARCH_DIO)
abstract class SearchBookApi{
  factory SearchBookApi(Dio dio) = _SearchBookApi;

  @GET(ENDPOINT_GET_SEARCH_LIST)
  Future<SearchBookResponse> getSearchBookList(
      @Query(PARAM_Q) String? q,
      );
}