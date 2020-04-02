// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_photos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    json['id'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['promoted_at'] as String,
    json['width'] as int,
    json['height'] as int,
    json['color'] as String,
    json['description'] as String,
    json['alt_description'] as String,
    json['views'] as int,
    json['downloads'] as int,
    json['likes'] as int,
    json['liked_by_user'] as bool,
    json['urls'] == null
        ? null
        : Urls.fromJson(json['urls'] as Map<String, dynamic>),
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    json['categories'] as List,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['current_user_collections'] as List,
    json['exif'] == null
        ? null
        : Exif.fromJson(json['exif'] as Map<String, dynamic>),
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    json['position'] == null
        ? null
        : Position.fromJson(json['position'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'promoted_at': instance.promotedAt,
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'description': instance.description,
      'alt_description': instance.altDescription,
      'exif': instance.exif,
      'location': instance.location,
      'position': instance.position,
      'views': instance.views,
      'downloads': instance.downloads,
      'likes': instance.likes,
      'liked_by_user': instance.likedByUser,
      'urls': instance.urls,
      'links': instance.links,
      'categories': instance.categories,
      'user': instance.user,
      'current_user_collections': instance.currentUserCollections,
    };

PhotoStats _$PhotoStatsFromJson(Map<String, dynamic> json) {
  return PhotoStats(
    json['id'] as String,
    json['downloads'] == null
        ? null
        : StatValues.fromJson(json['downloads'] as Map<String, dynamic>),
    json['views'] == null
        ? null
        : StatValues.fromJson(json['views'] as Map<String, dynamic>),
    json['likes'] == null
        ? null
        : StatValues.fromJson(json['likes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PhotoStatsToJson(PhotoStats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'downloads': instance.downloads,
      'views': instance.views,
      'likes': instance.likes,
    };

StatValues _$StatValuesFromJson(Map<String, dynamic> json) {
  return StatValues(
    json['total'] as int,
    json['historical'] == null
        ? null
        : HistoricalStats.fromJson(json['historical'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StatValuesToJson(StatValues instance) =>
    <String, dynamic>{
      'total': instance.total,
      'historical': instance.historical,
    };

HistoricalStats _$HistoricalStatsFromJson(Map<String, dynamic> json) {
  return HistoricalStats(
    json['change'] as int,
    _$enumDecodeNullable(_$StatResolutionEnumMap, json['resolution']),
    json['quantity'] as int,
    (json['values'] as List)
        ?.map((e) =>
            e == null ? null : StatValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HistoricalStatsToJson(HistoricalStats instance) =>
    <String, dynamic>{
      'change': instance.change,
      'resolution': _$StatResolutionEnumMap[instance.resolution],
      'quantity': instance.quantity,
      'values': instance.values,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StatResolutionEnumMap = {
  StatResolution.days: 'days',
};

StatValue _$StatValueFromJson(Map<String, dynamic> json) {
  return StatValue(
    json['date'] as String,
    json['value'] as int,
  );
}

Map<String, dynamic> _$StatValueToJson(StatValue instance) => <String, dynamic>{
      'date': instance.date,
      'value': instance.value,
    };

Exif _$ExifFromJson(Map<String, dynamic> json) {
  return Exif(
    json['make'] as String,
    json['model'] as String,
    json['exposure_time'] as String,
    json['aperture'] as String,
    json['focal_length'] as String,
    json['iso'] as int,
  );
}

Map<String, dynamic> _$ExifToJson(Exif instance) => <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'exposure_time': instance.exposureTime,
      'aperture': instance.aperture,
      'focal_length': instance.focal_length,
      'iso': instance.iso,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['title'] as String,
    json['name'] as String,
    json['city'] as String,
    json['country'] as String,
    json['position'] == null
        ? null
        : Position.fromJson(json['position'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'title': instance.title,
      'name': instance.name,
      'city': instance.city,
      'country': instance.country,
      'position': instance.position,
    };

Position _$PositionFromJson(Map<String, dynamic> json) {
  return Position(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
