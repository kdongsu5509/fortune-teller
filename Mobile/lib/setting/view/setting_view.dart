import 'package:ai_fortune_teller_app/setting/view_model/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/router.dart';
import '../app_theme_provider.dart';

class SettingsView extends ConsumerWidget {
  SettingsView({super.key});

  final SettingViewModel viewModel = SettingViewModel(null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sized = MediaQuery.of(context).size;
    final sw = sized.width;
    final isDark = ref.watch(currentThemeModeProvider) == ThemeMode.dark;

    String pageTitle = '환경 설정';

    List<String> titleList = [
      '내 정보',
      '다크 모드',
      '알림 설정[미구현]',
      '개인정보 처리방침',
      '로그아웃[미구현]',
    ];

    List<Icon> tileIcons = [
      const Icon(Icons.account_circle),
      const Icon(Icons.brightness_6),
      const Icon(Icons.notifications),
      const Icon(Icons.lock),
      const Icon(Icons.logout),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(height: sw * 0.03),
          Text(
            pageTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: sw * 0.06),
          ),
          const Divider(),

          ListTile(
            leading: tileIcons[0],
            title: Text(titleList[0]),
            onTap: () {
              router.push('/settings/user');
            },
          ),

          SwitchListTile(
            secondary: tileIcons[1],
            title: Text(titleList[1]),
            value: isDark,
            onChanged: (value) {
              viewModel.toggleTheme(ref);
            },
          ),

          ListTile(
            leading: tileIcons[2],
            title: Text(titleList[2]),
            onTap: () {
              // 알림 설정 화면으로 연결
            },
          ),

          ListTile(
            leading: tileIcons[3],
            title: Text(titleList[3]),
            onTap: () {
              router.push('/settings/privacy');
            },
          ),

          ListTile(
            leading: tileIcons[4],
            title: Text(titleList[4]),
            onTap: () {
              // 로그아웃 처리
            },
          ),
        ],
      ),
    );
  }
}
