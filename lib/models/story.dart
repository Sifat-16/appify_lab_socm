import 'package:appify_lab_socm/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'story.g.dart';

@JsonSerializable()
class Story {
   Profile user;
   String imageUrl;
   bool isViewed;

   Story({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });

   factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
   Map<String, dynamic> toJson() => _$StoryToJson(this);
}