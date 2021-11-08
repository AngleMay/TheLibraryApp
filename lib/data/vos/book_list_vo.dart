import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
part 'book_list_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_BOOK_LIST_VO,adapterName: "BookListVOAdapter")
@JsonSerializable()
class BookListVO{

  @JsonKey(name: "list_id")
  @HiveField(0)
  int? listId;

  @JsonKey(name: "list_name")
  @HiveField(1)
  String? listName;

  @JsonKey(name: "list_name_encoded")
  @HiveField(2)
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  @HiveField(3)
  String? displayName;

  @JsonKey(name: "updated")
  @HiveField(4)
  String? updated;

  @JsonKey(name: "list_image")
  @HiveField(5)
  String? listImage;

  @JsonKey(name: "list_image_width")
  @HiveField(6)
  String? listImageWidth;

  @JsonKey(name: "list_image_height")
  @HiveField(7)
  String? listImageHeight;

  @JsonKey(name: "books")
  @HiveField(8)
  List<BookVO>? books;


  @JsonKey(name: "bestsellers_date")
  @HiveField(9)
  String? bestSellersDate;

  @JsonKey(name: "published_date")
  @HiveField(10)
  String? publishedDate;

  @JsonKey(name: "normal_list_ends_at")
  @HiveField(11)
  int? normalListEndsAt;

  @JsonKey(name: "corrections")
  @HiveField(12)
  List? corrections;


  BookListVO(
      this.listId,
      this.listName,
      this.listNameEncoded,
      this.displayName,
      this.updated,
      this.listImage,
      this.listImageWidth,
      this.listImageHeight,
      this.books,
      this.bestSellersDate,
      this.publishedDate,
      this.normalListEndsAt,
      this.corrections);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookListVO &&
          runtimeType == other.runtimeType &&
          listId == other.listId &&
          listName == other.listName;

  @override
  int get hashCode => listId.hashCode ^ listName.hashCode;

  factory BookListVO.fromJson(Map<String, dynamic> json) =>
      _$BookListVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookListVOToJson(this);
}