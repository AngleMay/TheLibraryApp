import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/access_info_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/sale_info_vo.dart';
import 'package:the_library/data/vos/search_info_vo.dart';
import 'package:the_library/data/vos/volume_info_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

part 'search_book_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_SEARCH_BOOK_VO, adapterName: "SearchBookVOAdapter")
class SearchBookVO {
  @JsonKey(name: "kind")
  @HiveField(0)
  String? kind;

  @JsonKey(name: "id")
  @HiveField(1)
  String? id;

  @JsonKey(name: "etag")
  @HiveField(2)
  String? etag;

  @JsonKey(name: "selfLink")
  @HiveField(3)
  String? selfLink;

  @JsonKey(name: "volumeInfo")
  @HiveField(4)
  VolumeInfoVO? volumeInfo;

  @JsonKey(name: "saleInfo")
  @HiveField(5)
  SaleInfoVO? saleInfo;

  @JsonKey(name: "accessInfo")
  @HiveField(6)
  AccessInfoVO? accessInfo;

  @JsonKey(name: "searchInfo")
  @HiveField(7)
  SearchInfoVO? searchInfo;

  SearchBookVO(
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  );

  BookVO convertToBookVO(SearchBookVO sbBook) {
    return BookVO(
        "",
        "",
        "",
        sbBook?.volumeInfo?.authors?[0],
        sbBook.volumeInfo?.imageLinks?.thumbnail ??
            "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
        0,
        0,
        "",
        "",
        "",
        "",
        sbBook.volumeInfo?.description ?? "",
        "",
        "",
        sbBook.volumeInfo?.industryIdentifiers?[0].identifier ?? "",
        "",
        "",
        sbBook.volumeInfo?.publisher,
        0,
        0,
        "",
        sbBook.volumeInfo?.title ?? "",
        "",
        0,
        [],
        0,
        0,
        []);
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchBookVO &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory SearchBookVO.fromJson(Map<String, dynamic> json) =>
      _$SearchBookVOFromJson(json);
  Map<String, dynamic> toJson() => _$SearchBookVOToJson(this);
}
