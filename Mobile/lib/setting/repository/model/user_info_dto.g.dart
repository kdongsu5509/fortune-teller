// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoDTO _$UserInfoDTOFromJson(Map<String, dynamic> json) => UserInfoDTO(
  name: json['name'] as String,
  birthDate: DateTime.parse(json['birthDate'] as String),
  birthTime: $enumDecode(_$BirthTimeEnumMap, json['birthTime']),
  gender: json['gender'] as String,
);

Map<String, dynamic> _$UserInfoDTOToJson(UserInfoDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'birthTime': _$BirthTimeEnumMap[instance.birthTime]!,
      'gender': instance.gender,
    };

const _$BirthTimeEnumMap = {
  BirthTime.Missing: 'Missing',
  BirthTime.Ja: 'Ja',
  BirthTime.Chuk: 'Chuk',
  BirthTime.In: 'In',
  BirthTime.Myo: 'Myo',
  BirthTime.Jin: 'Jin',
  BirthTime.Sa: 'Sa',
  BirthTime.O: 'O',
  BirthTime.Mi: 'Mi',
  BirthTime.Sin: 'Sin',
  BirthTime.Yu: 'Yu',
  BirthTime.Sul: 'Sul',
  BirthTime.Hae: 'Hae',
};
