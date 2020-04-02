import 'package:json_annotation/json_annotation.dart';

part '_stats.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class TotalStats {
  factory TotalStats.fromJson(Map<String, dynamic> json) =>
      _$TotalStatsFromJson(json);

  TotalStats(
      this.photos,
      this.downloads,
      this.views,
      this.likes,
      this.photographers,
      this.pixels,
      this.downloadsPerSecond,
      this.viewsPerSecond,
      this.developers,
      this.applications,
      this.requests);

  final int photos;
  final int downloads;
  final int views;
  final int likes;
  final int photographers;
  final int pixels;
  final int downloadsPerSecond;
  final int viewsPerSecond;
  final int developers;
  final int applications;
  final int requests;

  Map<String, dynamic> toJson() => _$TotalStatsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MonthStats {
  factory MonthStats.fromJson(Map<String, dynamic> json) =>
      _$MonthStatsFromJson(json);

  MonthStats(
      this.downloads,
      this.views,
      this.likes,
      this.newPhotos,
      this.newPhotographers,
      this.newPixels,
      this.newDevelopers,
      this.newApplications,
      this.newRequests);

  final int downloads;
  final int views;
  final int likes;
  final int newPhotos;
  final int newPhotographers;
  final int newPixels;
  final int newDevelopers;
  final int newApplications;
  final int newRequests;

  Map<String, dynamic> toJson() => _$MonthStatsToJson(this);
}
