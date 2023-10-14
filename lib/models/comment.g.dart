// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String?,
      comment: json['comment'] as String?,
      post: json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      owner: json['owner'] == null
          ? null
          : Profile.fromJson(json['owner'] as Map<String, dynamic>),
      isReply: json['isReply'] as bool?,
      parentComment: json['parentComment'] == null
          ? null
          : Comment.fromJson(json['parentComment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'owner': instance.owner?.toJson(),
      'post': instance.post?.toJson(),
      'isReply': instance.isReply,
      'parentComment': instance.parentComment?.toJson(),
    };
