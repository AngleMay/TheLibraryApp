import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
part 'buy_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_BUY_VO,adapterName: "BuyVOAdapter")
@JsonSerializable()
class BuyVO{
  @JsonKey(name: "name")
  @HiveField(0)
  String? name;

  @JsonKey(name: "url")
  @HiveField(1)
  String? url;

  BuyVO(this.name,this.url);

  factory BuyVO.fromJson(Map<String, dynamic> json) =>
      _$BuyVOFromJson(json);

  Map<String, dynamic> toJson() => _$BuyVOToJson(this);
}