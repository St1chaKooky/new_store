
import 'package:json_annotation/json_annotation.dart';

part 'current_auth_model.g.dart';
@JsonSerializable()
class  CurrentAuthModel {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String image;
   CurrentAuthModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.image,
  });

  factory CurrentAuthModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentAuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentAuthModelToJson(this);
}