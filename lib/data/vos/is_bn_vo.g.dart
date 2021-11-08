// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_bn_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsBnVOAdapter extends TypeAdapter<IsBnVO> {
  @override
  final int typeId = 7;

  @override
  IsBnVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsBnVO(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IsBnVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isBn10)
      ..writeByte(1)
      ..write(obj.isBn13);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsBnVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsBnVO _$IsBnVOFromJson(Map<String, dynamic> json) => IsBnVO(
      json['isbn10'] as String?,
      json['isbn13'] as String?,
    );

Map<String, dynamic> _$IsBnVOToJson(IsBnVO instance) => <String, dynamic>{
      'isbn10': instance.isBn10,
      'isbn13': instance.isBn13,
    };
