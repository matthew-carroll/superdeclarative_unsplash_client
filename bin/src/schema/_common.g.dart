// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    json['raw'] as String,
    json['full'] as String,
    json['regular'] as String,
    json['small'] as String,
    json['thumb'] as String,
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(
    json['self'] as String,
    json['html'] as String,
    json['photos'] as String,
    json['portfolio'] as String,
    json['download'] as String,
    json['download_location'] as String,
    json['likes'] as String,
    json['following'] as String,
    json['followers'] as String,
  );
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'self': instance.self,
      'html': instance.html,
      'photos': instance.photos,
      'portfolio': instance.portfolio,
      'download': instance.download,
      'download_location': instance.download_location,
      'likes': instance.likes,
      'following': instance.following,
      'followers': instance.followers,
    };
