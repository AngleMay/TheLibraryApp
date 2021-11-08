import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
part 'shelf_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_SHELF_VO, adapterName: "ShelfVOAdapter")
class ShelfVO {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? shelfName;

  @HiveField(2)
  List<BookVO?>? bookList;

  bool? isEmpty;

  ShelfVO(this.id, this.shelfName, this.bookList, {this.isEmpty = false});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          shelfName == other.shelfName;

  @override
  int get hashCode => id.hashCode ^ shelfName.hashCode;

  factory ShelfVO.fromJson(Map<String, dynamic> json) =>
      _$ShelfVOFromJson(json);

  Map<String, dynamic> toJson() => _$ShelfVOToJson(this);
}