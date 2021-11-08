import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
part 'is_bn_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_BOOK_IS_BN_VO, adapterName: "IsBnVOAdapter")
class IsBnVO{
  @JsonKey(name: "isbn10")
  @HiveField(0)
  String? isBn10;

  @JsonKey(name: "isbn13")
  @HiveField(1)
  String? isBn13;

  IsBnVO(this.isBn10, this.isBn13);


  factory IsBnVO.fromJson(Map<String, dynamic> json) =>
      _$IsBnVOFromJson(json);

  Map<String, dynamic> toJson() => _$IsBnVOToJson(this);
}