import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Text('환경 설정', style: Theme.of(context).textTheme.titleLarge),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('언어'),
            subtitle: const Text('한국어'),
            onTap: () {
              // 향후 다국어 설정 화면으로 연결
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.brightness_6),
            title: const Text('다크 모드'),
            value: isDark,
            onChanged: (value) {
              // 테마 전환은 상단 ThemeIconButton으로 대체하거나 Provider 연동 가능
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('알림 설정'),
            onTap: () {
              // 알림 설정 화면으로 연결
            },
          ),

          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('개인정보 처리방침'),
            onTap: () {
              // 정책 페이지로 이동
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('로그아웃'),
            onTap: () {
              // 로그아웃 처리
            },
          ),
        ],
      ),
    );
  }
}
