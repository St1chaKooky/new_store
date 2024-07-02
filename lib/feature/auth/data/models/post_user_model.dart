import 'package:json_annotation/json_annotation.dart';

part 'post_user_model.g.dart';

@JsonSerializable()
class PostUserModel {
  final String username;
  final String password;
  @JsonKey(defaultValue: 30)
  final int expiresInMins;

  const PostUserModel({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  factory PostUserModel.fromJson(Map<String, dynamic> json) =>
      _$PostUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostUserModelToJson(this);
}
