// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['updated_at'] as String,
    json['username'] as String,
    json['name'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['twitter_username'] as String,
    json['instagram_username'] as String,
    json['portfolio_url'] as String,
    json['bio'] as String,
    json['location'] as String,
    json['profile_image'] == null
        ? null
        : ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>),
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    json['total_collections'] as int,
    json['total_likes'] as int,
    json['total_photos'] as int,
    json['accepted_tos'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'twitter_username': instance.twitterUsername,
      'instagram_username': instance.instagramUsername,
      'portfolio_url': instance.portfolioUrl,
      'bio': instance.bio,
      'location': instance.location,
      'accepted_tos': instance.acceptedTos,
      'profile_image': instance.profileImage,
      'total_collections': instance.totalCollections,
      'total_likes': instance.totalLikes,
      'total_photos': instance.totalPhotos,
      'links': instance.links,
    };

ProfileImage _$ProfileImageFromJson(Map<String, dynamic> json) {
  return ProfileImage(
    json['small'] as String,
    json['medium'] as String,
    json['large'] as String,
  );
}

Map<String, dynamic> _$ProfileImageToJson(ProfileImage instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
