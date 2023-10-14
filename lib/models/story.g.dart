// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      user: Profile.fromJson(json['user'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      isViewed: json['isViewed'] as bool? ?? false,
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'user': instance.user,
      'imageUrl': instance.imageUrl,
      'isViewed': instance.isViewed,
    };
