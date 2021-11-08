import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
part 'book_list_results_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_BOOK_LIST_RESULTS_VO,adapterName: "BookListResultsVOAdapter")
@JsonSerializable()
class BookListResultsVO{

  @JsonKey(name: "bestsellers_date")
  @HiveField(0)
  String? bestSellersDate;

  @JsonKey(name: "published_date")
  @HiveField(1)
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  @HiveField(2)
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  @HiveField(3)
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  @HiveField(4)
  String? nextPublishedDate;

  @JsonKey(name: "lists")
  @HiveField(5)
  List<BookListVO>? lists;

  BookListResultsVO(
      this.bestSellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.lists);

  factory BookListResultsVO.fromJson(Map<String, dynamic> json) =>
      _$BookListResultsVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookListResultsVOToJson(this);

}