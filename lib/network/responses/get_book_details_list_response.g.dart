// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_details_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookDetailsListResponse _$GetBookDetailsListResponseFromJson(
        Map<String, dynamic> json) =>
    GetBookDetailsListResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['last_modified'] as String?,
      json['results'] == null
          ? null
          : BookListVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBookDetailsListResponseToJson(
        GetBookDetailsListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'last_modified': instance.lastModified,
      'results': instance.results,
    };
