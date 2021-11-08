import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/book_details_list_vo.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
part 'get_book_details_list_response.g.dart';

@JsonSerializable()
class GetBookDetailsListResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "last_modified")
  String? lastModified;

  @JsonKey(name: "results")
  BookListVO? results;

  GetBookDetailsListResponse(this.status, this.copyright, this.numResults,
      this.lastModified, this.results);

  factory GetBookDetailsListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBookDetailsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookDetailsListResponseToJson(this);
}
