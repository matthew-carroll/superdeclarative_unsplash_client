import 'package:json_annotation/json_annotation.dart';

import '_common.dart';

part '_user.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class User {
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(
      this.id,
      this.updatedAt,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.instagramUsername,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.profileImage,
      this.links,
      this.totalCollections,
      this.totalLikes,
      this.totalPhotos,
      this.acceptedTos);

  final String id;
  final String updatedAt;
  final String username;
  final String name;
  final String firstName;
  final String lastName;
  final String twitterUsername;
  final String instagramUsername;
  final String portfolioUrl;
  final String bio;
  final String location;
  final bool acceptedTos;
  final ProfileImage profileImage;
  final int totalCollections;
  final int totalLikes;
  final int totalPhotos;
  final Links links;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => '''
ID: $id
Updated at: $updatedAt
Username: $username
Name: $name
First Name: $firstName
Last Name: $lastName
Twitter: $twitterUsername
Instagram: $instagramUsername
Portfolio: $portfolioUrl
Bio: $bio
Location: $location
Accepted ToS: $acceptedTos
Profile Image: $profileImage
Total Collections: $totalCollections
Total Likes: $totalLikes
Total Photos: $totalPhotos
Links: $links
  ''';
}

@JsonSerializable()
class ProfileImage {
  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);

  ProfileImage(this.small, this.medium, this.large);

  final String small;
  final String medium;
  final String large;

  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);

  @override
  String toString() => '''
Small: $small
Medium: $medium
Large: $large
  ''';
}
