// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAuthModel _$CurrentAuthModelFromJson(Map<String, dynamic> json) =>
    CurrentAuthModel(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      maidenName: json['maidenName'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CurrentAuthModelToJson(CurrentAuthModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'maidenName': instance.maidenName,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
      'image': instance.image,
    };
