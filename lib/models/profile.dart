import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';

@JsonSerializable()
class Profile{
  String? email;
  String? username;
  String? uid;
  String? profilePhoto;

  Profile({
    this.email,
    this.username,
    this.uid,
    this.profilePhoto
});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}