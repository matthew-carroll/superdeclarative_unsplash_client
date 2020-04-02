import 'package:json_annotation/json_annotation.dart';

import '_common.dart';
import '_user.dart';

part '_collections.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Collection {
  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Collection(
      this.id,
      this.title,
      this.description,
      this.publishedAt,
      this.updatedAt,
      this.featured,
      this.totalPhotos,
      this.private,
      this.shareKey,
      this.coverPhoto,
      this.user,
      this.links);

  final int id;
  final String title;
  final String description;
  final String publishedAt;
  final String updatedAt;
  final bool featured;
  final int totalPhotos;
  final bool private;
  final String shareKey;
  final dynamic coverPhoto;
  final User user;
  final Links links;

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @override
  String toString() => '''
ID: $id
Title: $title
Description: $description
Published At: $publishedAt
Updated At: $updatedAt
Featured: $featured
Total Photos: $totalPhotos
Private: $private
Share Key: $shareKey
Cover Photo: $coverPhoto
User: 
$user
Links:
$links
  ''';
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class CoverPhoto {
  CoverPhoto(
      this.id,
      this.createdAt,
      this.updatedAt,
      this.promotedAt,
      this.width,
      this.height,
      this.description,
      this.altDescription,
      this.color,
      this.likes,
      this.likedByUser,
      this.urls,
      this.links,
      this.categories,
      this.currentUserCollections,
      this.user);

  final String id;
  final String createdAt;
  final String updatedAt;
  final String promotedAt;
  final int width;
  final int height;
  final String description;
  final String altDescription;
  final String color;
  final int likes;
  final bool likedByUser;
  final Urls urls;
  final Links links;
  final List<String> categories;
  final List<String> currentUserCollections;
  final User user;
}
