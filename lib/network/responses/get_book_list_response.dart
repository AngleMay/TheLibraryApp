import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/book_list_results_vo.dart';
part 'get_book_list_response.g.dart';

@JsonSerializable()
class GetBookListResponse{

  // "status": "OK",
  // "copyright": "Copyright (c) 2021 The New York Times Company.  All Rights Reserved.",
  // "num_results": 90,
  // "results": {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyRight;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  BookListResultsVO? results;

  GetBookListResponse(
      this.status, this.copyRight, this.numResults, this.results);

  factory GetBookListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBookListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookListResponseToJson(this);

}