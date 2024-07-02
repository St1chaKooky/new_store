// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUserModel _$PostUserModelFromJson(Map<String, dynamic> json) =>
    PostUserModel(
      username: json['username'] as String,
      password: json['password'] as String,
      expiresInMins: (json['expiresInMins'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$PostUserModelToJson(PostUserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'expiresInMins': instance.expiresInMins,
    };
