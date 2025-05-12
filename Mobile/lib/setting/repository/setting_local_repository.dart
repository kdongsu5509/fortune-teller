import 'package:ai_fortune_teller_app/setting/repository/model/user_info_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SettingLocalRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static final SettingLocalRepository _instance = SettingLocalRepository._internal();

  SettingLocalRepository._internal();

  factory SettingLocalRepository() => _instance;

  Future<void> saveUserInfo(UserInfoDTO userInfo) async {
    final jsonString = jsonEncode(userInfo.toJson());
    await _storage.write(key: 'userInfo', value: jsonString);
  }

  Future<UserInfoDTO?> getUserInfo() async {
    final jsonString = await _storage.read(key: 'userInfo');
    if (jsonString == null) return null;
    return UserInfoDTO.fromJson(jsonDecode(jsonString));
  }

  Future<void> deleteUserInfo() async {
    await _storage.delete(key: 'userInfo');
  }

  Future<UserInfoDTO> updateUserInfo(UserInfoDTO userInfo) async {
    await deleteUserInfo();
    await saveUserInfo(userInfo);
    return userInfo;
  }

  Future<void> deleteAllSettings() async {
    await _storage.deleteAll();
  }
}
