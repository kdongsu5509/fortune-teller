import 'package:ai_fortune_teller_app/setting/view_model/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/router.dart';
import '../app_theme_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SettingViewModel viewModel = SettingViewModel();
    final isDark = ref.watch(currentThemeModeProvider) == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Text('환경 설정', style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFamily: "ChosunCentennial",
          )),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('내 정보'),
            onTap: () {
              router.push('/settings/user');
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.brightness_6),
            title: const Text('다크 모드'),
            value: isDark,
            onChanged: (value) {
              // viewModel.toggleTheme(ref);
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('알림 설정[미구현]'),
            onTap: () {
              // 알림 설정 화면으로 연결
            },
          ),

          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('개인정보 처리방침'),
            onTap: () {
              router.push('/settings/privacy');
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('로그아웃[미구현]'),
            onTap: () {
              // 로그아웃 처리
            },
          ),
        ],
      ),
    );
  }
}
