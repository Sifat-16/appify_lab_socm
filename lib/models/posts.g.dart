// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String?,
      user: json['user'] == null
          ? null
          : Profile.fromJson(json['user'] as Map<String, dynamic>),
      caption: json['caption'] as String?,
      timeAgo: json['timeAgo'] as String?,
      imageUrl: json['imageUrl'] as String?,
      likes: json['likes'] as int?,
      comments: json['comments'] as int?,
      shares: json['shares'] as int?,
      backgroundColor: json['backgroundColor'] as String?,
      postType: json['postType'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'caption': instance.caption,
      'timeAgo': instance.timeAgo,
      'imageUrl': instance.imageUrl,
      'backgroundColor': instance.backgroundColor,
      'likes': instance.likes,
      'comments': instance.comments,
      'shares': instance.shares,
      'postType': instance.postType,
    };
