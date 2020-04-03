import 'package:json_annotation/json_annotation.dart';

part '_common.g.dart';

@JsonSerializable()
class Urls {
  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Urls(this.raw, this.full, this.regular, this.small, this.thumb);

  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Map<String, dynamic> toJson() => _$UrlsToJson(this);

  @override
  String toString() => '''
Raw: $raw
Full: $full
Regular: $regular
Small: $small
Thumbnail: $thumb
  ''';
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Links {
  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Links(this.self, this.html, this.photos, this.portfolio, this.download,
      this.download_location, this.likes, this.following, this.followers);

  final String self;
  final String html;
  final String photos;
  final String portfolio;
  final String download;
  final String download_location;
  final String likes;
  final String following;
  final String followers;

  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @override
  String toString() => '''
Self: $self
HTML: $html
Photos: $photos
Portfolio: $portfolio
Download: $download
Download Location: $download_location
Likes: $likes
Following: $following
Followers: $followers
  ''';
}
