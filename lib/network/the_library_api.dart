import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_library/network/api_constants.dart';
import 'package:the_library/network/responses/get_book_details_list_response.dart';
import 'package:the_library/network/responses/get_book_list_response.dart';
part 'the_library_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheLibraryApi {
  factory TheLibraryApi(Dio dio) = _TheLibraryApi;

  @GET(ENDPOINT_GET_BOOK_LIST)
  Future<GetBookListResponse> getBookList(
    @Query(PARAM_PUBLISHED_DATE) String publishedDate,
    @Query(PARAM_API_KEY) String apiKey,
  );

  @GET("$ENDPOINT_GET_BOOK_LIST_DETAILS/{published_date}/{list}.json")
  Future<GetBookDetailsListResponse> getBookDetailsList(
    @Path(PARAM_LIST) String listName,
    @Path(PARAM_PUBLISHED_DATE) String publishedDate,
    @Query(PARAM_API_KEY) String apiKey,
  );

}
