import 'package:json_annotation/json_annotation.dart';

import '_photos.dart';
import '_collections.dart';
import '_user.dart';

part '_search.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class CollectionSearchPage {
  factory CollectionSearchPage.fromJson(Map<String, dynamic> json) =>
      _$CollectionSearchPageFromJson(json);

  CollectionSearchPage(this.total, this.totalPages, this.results);

  final int total;
  final int totalPages;
  final List<Collection> results;

  Map<String, dynamic> toJson() => _$CollectionSearchPageToJson(this);

  @override
  String toString() => '''
Total: $total
Total Pages: $totalPages
Results:
$results 
  ''';
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class PhotoSearchPage {
  factory PhotoSearchPage.fromJson(Map<String, dynamic> json) =>
      _$PhotoSearchPageFromJson(json);

  PhotoSearchPage(this.total, this.totalPages, this.results);

  final int total;
  final int totalPages;
  final List<Photo> results;

  Map<String, dynamic> toJson() => _$PhotoSearchPageToJson(this);

  @override
  String toString() => '''
Total: $total
Total Pages: $totalPages
Results:
$results
  ''';
}

enum SearchOrder {
  relevant,
  latest,
}

enum SearchContentFilter {
  low,
  high,
}

enum SearchColorFilter {
  blackAndWhite,
  black,
  white,
  yellow,
  orange,
  red,
  purple,
  magenta,
  green,
  teal,
  blue,
}

enum SearchOrientation {
  landscape,
  portrait,
  squarish,
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserSearchPage {
  factory UserSearchPage.fromJson(Map<String, dynamic> json) =>
      _$UserSearchPageFromJson(json);

  UserSearchPage(this.total, this.totalPages, this.results);

  final int total;
  final int totalPages;
  final List<User> results;

  Map<String, dynamic> toJson() => _$UserSearchPageToJson(this);

  @override
  String toString() => '''
Total: $total
Total Pages: $totalPages
Results:
$results 
  ''';
}
