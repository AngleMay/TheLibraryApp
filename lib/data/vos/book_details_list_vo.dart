import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/book_details_vo.dart';
import 'package:the_library/data/vos/is_bn_vo.dart';
import 'package:the_library/data/vos/review_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
part 'book_details_list_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_DETAILS_LIST_VO,adapterName: "BookDetailsListVOAdapter")
class BookDetailsListVO{

  @JsonKey(name: "list_name")
  @HiveField(0)
  String? listName;

  @JsonKey(name: "display_name")
  @HiveField(1)
  String? displayName;

  @JsonKey(name: "bestsellers_date")
  @HiveField(2)
  String? bestSellersDate;

  @JsonKey(name: "published_date")
  @HiveField(3)
  String? publishedDate;

  @JsonKey(name: "rank")
  @HiveField(4)
  int? rank;

  @JsonKey(name: "rank_last_week")
  @HiveField(5)
  int? rankLastWeek;

  @JsonKey(name: "weeks_on_list")
  @HiveField(6)
  int? weeksOnList;

  @JsonKey(name: "asterisk")
  @HiveField(7)
  int asterisk;

  @JsonKey(name: "dagger")
  @HiveField(8)
  int? dagger;

  @JsonKey(name: "amazon_product_url")
  @HiveField(9)
  String? amazonProductUrl;

  @JsonKey(name: "isbns")
  @HiveField(10)
  List<IsBnVO>? isBns;

  @JsonKey(name: "book_details")
  @HiveField(11)
  List<BookDetailsVO>? bookDetails;

  @JsonKey(name: "reviews")
  @HiveField(12)
  List<ReviewVO>? reviews;

  BookDetailsListVO(
      this.listName,
      this.displayName,
      this.bestSellersDate,
      this.publishedDate,
      this.rank,
      this.rankLastWeek,
      this.weeksOnList,
      this.asterisk,
      this.dagger,
      this.amazonProductUrl,
      this.isBns,
      this.bookDetails,
      this.reviews);

  factory BookDetailsListVO.fromJson(Map<String, dynamic> json) =>
      _$BookDetailsListVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookDetailsListVOToJson(this);
}