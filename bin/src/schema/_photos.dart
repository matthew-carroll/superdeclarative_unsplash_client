import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';

import '_common.dart';
import '_user.dart';

part '_photos.g.dart';

class PhotoListPage {
  factory PhotoListPage.fromJson({
    int pageIndex,
    int perPage,
    PhotosPageOrder orderBy,
    dynamic json,
  }) {
    assert(json is List<dynamic>);

    final List<Photo> photoList = json
        .map<Photo>((dynamic photoJson) => Photo.fromJson(photoJson))
        .toList(growable: false);

    return PhotoListPage(
      pageIndex: pageIndex,
      perPage: perPage,
      orderBy: orderBy,
      photos: photoList,
    );
  }

  PhotoListPage({
    this.pageIndex,
    this.perPage,
    this.orderBy,
    this.photos,
  });

  final int pageIndex;
  final int perPage;
  final PhotosPageOrder orderBy;
  final List<Photo> photos;

  @override
  String toString() => '''
PhotosPage:
Page Index: $pageIndex
Per Page: $perPage
Order by: $orderBy
Photos:
$photos
  ''';
}

enum PhotosPageOrder {
  latest,
  oldest,
  popular,
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Photo {
  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Photo(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.views,
    this.downloads,
    this.likes,
    this.likedByUser,
    this.urls,
    this.links,
    this.categories,
    this.user,
    this.currentUserCollections,
    this.exif,
    this.location,
    this.position,
  );

  final String id;
  final String createdAt;
  final String updatedAt;
  final String promotedAt;
  final int width;
  final int height;
  final String color;
  final String description;
  final String altDescription;
  final Exif exif;
  final Location location;
  final Position position;
  final int views;
  final int downloads;
  final int likes;
  final bool likedByUser;
  final Urls urls;
  final Links links;
  final List<dynamic> categories;
  final User user;
  final List<dynamic> currentUserCollections;

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  String toString() => '''
ID: $id
Size: $width x $height
Description: $description
Alt-Description: $altDescription
Views: $views
Downloads: $downloads
Likes: $likes
Liked by user: $likedByUser
Urls: 
$urls
Links: 
$links
Categories: 
$categories
User: 
$user
Current user collections: 
$currentUserCollections
Exif: 
$exif
Location: 
$location
Position: 
$position
  ''';
}

@JsonSerializable()
class PhotoStats {
  factory PhotoStats.fromJson(Map<String, dynamic> json) =>
      _$PhotoStatsFromJson(json);

  PhotoStats(this.id, this.downloads, this.views, this.likes);

  final String id;
  final StatValues downloads;
  final StatValues views;
  final StatValues likes;

  Map<String, dynamic> toJson() => _$PhotoStatsToJson(this);

  @override
  String toString() => '''
ID: $id
Downloads:
$downloads
Views:
$views
Likes:
$likes
  ''';
}

@JsonSerializable()
class StatValues {
  factory StatValues.fromJson(Map<String, dynamic> json) =>
      _$StatValuesFromJson(json);

  StatValues(this.total, this.historical);

  final int total;
  final HistoricalStats historical;

  Map<String, dynamic> toJson() => _$StatValuesToJson(this);

  @override
  String toString() => '''
Total: $total
Historical:
$historical
  ''';
}

@JsonSerializable()
class HistoricalStats {
  factory HistoricalStats.fromJson(Map<String, dynamic> json) =>
      _$HistoricalStatsFromJson(json);

  HistoricalStats(this.change, this.resolution, this.quantity, this.values);

  final int change;
  final StatResolution resolution;
  final int quantity;
  final List<StatValue> values;

  Map<String, dynamic> toJson() => _$HistoricalStatsToJson(this);

  @override
  String toString() => '''
Change: $change
Resolution: $resolution
Quantity: $quantity
Values:
$values
  ''';
}

@JsonSerializable()
class StatValue {
  factory StatValue.fromJson(Map<String, dynamic> json) =>
      _$StatValueFromJson(json);

  StatValue(this.date, this.value);

  final String date;
  final int value;

  Map<String, dynamic> toJson() => _$StatValueToJson(this);

  @override
  String toString() => '''
Date: $date
Value: $value
  ''';
}

enum StatResolution {
  days,
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Exif {
  factory Exif.fromJson(Map<String, dynamic> json) => _$ExifFromJson(json);

  Exif(this.make, this.model, this.exposureTime, this.aperture,
      this.focal_length, this.iso);

  final String make;
  final String model;
  final String exposureTime;
  final String aperture;
  final String focal_length;
  final int iso;

  Map<String, dynamic> toJson() => _$ExifToJson(this);

  @override
  String toString() => '''
Make: $make
Model: $model
Exposure Time: $exposureTime
Aperture: $aperture
Focal Length: $focal_length
ISO: $iso
  ''';
}

@JsonSerializable()
class Location {
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Location(this.title, this.name, this.city, this.country, this.position);

  final String title;
  final String name;
  final String city;
  final String country;
  final Position position;

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() => '''
Title: $title
Name: $name
City: $city
Country: $country
Position: $position
  ''';
}

@JsonSerializable()
class Position {
  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Position(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  @override
  String toString() => '''
Latitude: $latitude
Longitude: $longitude
  ''';
}
