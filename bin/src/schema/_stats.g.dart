// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalStats _$TotalStatsFromJson(Map<String, dynamic> json) {
  return TotalStats(
    json['photos'] as int,
    json['downloads'] as int,
    json['views'] as int,
    json['likes'] as int,
    json['photographers'] as int,
    json['pixels'] as int,
    json['downloads_per_second'] as int,
    json['views_per_second'] as int,
    json['developers'] as int,
    json['applications'] as int,
    json['requests'] as int,
  );
}

Map<String, dynamic> _$TotalStatsToJson(TotalStats instance) =>
    <String, dynamic>{
      'photos': instance.photos,
      'downloads': instance.downloads,
      'views': instance.views,
      'likes': instance.likes,
      'photographers': instance.photographers,
      'pixels': instance.pixels,
      'downloads_per_second': instance.downloadsPerSecond,
      'views_per_second': instance.viewsPerSecond,
      'developers': instance.developers,
      'applications': instance.applications,
      'requests': instance.requests,
    };

MonthStats _$MonthStatsFromJson(Map<String, dynamic> json) {
  return MonthStats(
    json['downloads'] as int,
    json['views'] as int,
    json['likes'] as int,
    json['new_photos'] as int,
    json['new_photographers'] as int,
    json['new_pixels'] as int,
    json['new_developers'] as int,
    json['new_applications'] as int,
    json['new_requests'] as int,
  );
}

Map<String, dynamic> _$MonthStatsToJson(MonthStats instance) =>
    <String, dynamic>{
      'downloads': instance.downloads,
      'views': instance.views,
      'likes': instance.likes,
      'new_photos': instance.newPhotos,
      'new_photographers': instance.newPhotographers,
      'new_pixels': instance.newPixels,
      'new_developers': instance.newDevelopers,
      'new_applications': instance.newApplications,
      'new_requests': instance.newRequests,
    };
