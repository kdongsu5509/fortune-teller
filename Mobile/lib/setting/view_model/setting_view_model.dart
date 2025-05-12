import 'dart:convert';

import 'package:ai_fortune_teller_app/setting/repository/model/user_info_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_fortune_teller_app/util/secure_storage.dart';

import '../app_theme_provider.dart';

class SettingViewModel extends StateNotifier<UserInfoDTO?> {
  final SecureStorage _secureStorage;

  void toggleTheme(WidgetRef ref) {
    final current = ref.read(currentThemeModeProvider);
    ref.read(currentThemeModeProvider.notifier).state =
    current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }


  SettingViewModel(this._secureStorage) : super(null) {
    _initUserInfo();
  }

  Future<void> _initUserInfo() async {
    final json = await _secureStorage.get('userInfo'); // ✅ await 추가
    if (json != null) {
      state = UserInfoDTO.fromJson(jsonDecode(json));
    }
  }

  Future<void> updateUserInfo(UserInfoDTO userInfo) async {
    await _secureStorage.set('userInfo', jsonEncode(userInfo.toJson()));
    state = userInfo;
  }

  Future<void> clearUserInfo() async {
    state = null;
    await _secureStorage.remove('userInfo');
  }
}
