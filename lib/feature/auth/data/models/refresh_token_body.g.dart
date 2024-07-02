// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenBody _$RefreshTokenBodyFromJson(Map<String, dynamic> json) =>
    RefreshTokenBody(
      refreshToken: json['refreshToken'] as String,
      expiresInMins: (json['expiresInMins'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$RefreshTokenBodyToJson(RefreshTokenBody instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'expiresInMins': instance.expiresInMins,
    };
