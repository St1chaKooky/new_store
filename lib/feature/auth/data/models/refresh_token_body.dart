import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_body.g.dart';

@JsonSerializable()
class RefreshTokenBody {
  final String refreshToken;
  @JsonKey(defaultValue: 30)
  final int expiresInMins;

  RefreshTokenBody({
    required this.refreshToken,
    this.expiresInMins = 30,
  });

  factory RefreshTokenBody.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenBodyFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenBodyToJson(this);
}
