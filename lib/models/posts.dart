import 'package:appify_lab_socm/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'posts.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  String?id;
   Profile? user;
   String? caption;
   String? timeAgo;
   String? imageUrl;
   String? backgroundColor;
   int? likes;
   int? comments;
   int? shares;
   String?postType;

   Post({
     this.id,
    this.user,
    this.caption,
    this.timeAgo,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
     this.backgroundColor,
     this.postType
  });

   factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
   Map<String, dynamic> toJson() => _$PostToJson(this);
}