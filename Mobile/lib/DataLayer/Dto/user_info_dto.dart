import 'package:flutter/foundation.dart'; // @immutable을 사용하기 위해 필요

@immutable
class UserInfoDTO {
  final String name;
  final int year;
  final int month;
  final int day;
  final String gender;

  const UserInfoDTO({
    required this.name,
    required this.year,
    required this.month,
    required this.day,
    required this.gender,
  });

  // JSON 변환 메서드 (객체 → Map)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'year': year,
      'month': month,
      'day': day,
      'gender': gender,
    };
  }
}
