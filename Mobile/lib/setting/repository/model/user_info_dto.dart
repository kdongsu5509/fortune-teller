import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'birth_time.dart';

part 'user_info_dto.g.dart';

@immutable
@JsonSerializable()
class UserInfoDTO {
  final String name;
  final DateTime birthDate; // yyyy-MM-dd
  final BirthTime birthTime;
  final String gender;

  const UserInfoDTO({
    required this.name,
    required this.birthDate,
    required this.birthTime,
    required this.gender,
  });

  factory UserInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDTOToJson(this);
}
