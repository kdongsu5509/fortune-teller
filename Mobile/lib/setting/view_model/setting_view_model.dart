import 'package:ai_fortune_teller_app/setting/repository/model/user_info_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme_provider.dart';

class SettingViewModel extends StateNotifier<UserInfoDTO?> {
  SettingViewModel(super.state);

  void toggleTheme(WidgetRef ref) {
    final current = ref.read(currentThemeModeProvider);
    ref.read(currentThemeModeProvider.notifier).state =
        current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
