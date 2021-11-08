// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookListResponse _$GetBookListResponseFromJson(Map<String, dynamic> json) =>
    GetBookListResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['results'] == null
          ? null
          : BookListResultsVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBookListResponseToJson(
        GetBookListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyRight,
      'num_results': instance.numResults,
      'results': instance.results,
    };
