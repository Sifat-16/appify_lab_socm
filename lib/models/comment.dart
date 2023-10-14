import 'package:appify_lab_socm/models/posts.dart';
import 'package:appify_lab_socm/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment{
  String? id;
  String? comment;
  Profile? owner;
  Post? post;
  bool? isReply;
  Comment? parentComment;
  Comment({
    this.id,
    this.comment,
    this.post,
    this.owner,
    this.isReply,
    this.parentComment
});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}


class CommentReplyObject{
  Comment comment;
  List<Comment> reply;
  CommentReplyObject({required this.comment, required this.reply});
}