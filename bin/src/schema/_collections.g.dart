// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_collections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['published_at'] as String,
    json['updated_at'] as String,
    json['featured'] as bool,
    json['total_photos'] as int,
    json['private'] as bool,
    json['share_key'] as String,
    json['cover_photo'],
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'published_at': instance.publishedAt,
      'updated_at': instance.updatedAt,
      'featured': instance.featured,
      'total_photos': instance.totalPhotos,
      'private': instance.private,
      'share_key': instance.shareKey,
      'cover_photo': instance.coverPhoto,
      'user': instance.user,
      'links': instance.links,
    };

CoverPhoto _$CoverPhotoFromJson(Map<String, dynamic> json) {
  return CoverPhoto(
    json['id'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['promoted_at'] as String,
    json['width'] as int,
    json['height'] as int,
    json['description'] as String,
    json['alt_description'] as String,
    json['color'] as String,
    json['likes'] as int,
    json['liked_by_user'] as bool,
    json['urls'] == null
        ? null
        : Urls.fromJson(json['urls'] as Map<String, dynamic>),
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    (json['categories'] as List)?.map((e) => e as String)?.toList(),
    (json['current_user_collections'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CoverPhotoToJson(CoverPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'promoted_at': instance.promotedAt,
      'width': instance.width,
      'height': instance.height,
      'description': instance.description,
      'alt_description': instance.altDescription,
      'color': instance.color,
      'likes': instance.likes,
      'liked_by_user': instance.likedByUser,
      'urls': instance.urls,
      'links': instance.links,
      'categories': instance.categories,
      'current_user_collections': instance.currentUserCollections,
      'user': instance.user,
    };
