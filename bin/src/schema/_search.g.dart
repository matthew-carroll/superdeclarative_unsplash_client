// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionSearchPage _$CollectionSearchPageFromJson(Map<String, dynamic> json) {
  return CollectionSearchPage(
    json['total'] as int,
    json['total_pages'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Collection.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CollectionSearchPageToJson(
        CollectionSearchPage instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };

PhotoSearchPage _$PhotoSearchPageFromJson(Map<String, dynamic> json) {
  return PhotoSearchPage(
    json['total'] as int,
    json['total_pages'] as int,
    (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PhotoSearchPageToJson(PhotoSearchPage instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };

UserSearchPage _$UserSearchPageFromJson(Map<String, dynamic> json) {
  return UserSearchPage(
    json['total'] as int,
    json['total_pages'] as int,
    (json['results'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserSearchPageToJson(UserSearchPage instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };
