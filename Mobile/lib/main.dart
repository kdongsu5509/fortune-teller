import 'dart:async';

import 'package:ai_fortune_teller_app/setting/app_theme.dart';
import 'package:ai_fortune_teller_app/setting/app_theme_provider.dart';
import 'package:ai_fortune_teller_app/setting/util/user_info_provider.dart';
import 'package:ai_fortune_teller_app/splash_screen.dart';
import 'package:ai_fortune_teller_app/util/provider_observer.dart';
import 'package:ai_fortune_teller_app/util/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'util/prefs.dart';
import 'common/router.dart';

/// @description
/// Flutter 애플리케이션의 진입점입니다.
///
/// 초기화
/// - 환경변수 파일(.env)을 로드합니다.
/// - Flutter의 위젯 바인딩을 초기화합니다.
/// - Riverpod의 ProviderScope를 사용하여 상태 관리를 설정합니다.
/// - ScreenUtil을 사용하여 화면 크기에 따라 UI를 조정합니다.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await dotenv.load(fileName: "ai_fortune_teller.env");
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: ScreenUtilInit(
        designSize: Size(412, 915),
        minTextAdapt: true,
        builder: (context, child) {
          return AIFortuneTellerApp();
        },
      ),
    ),
  );
}

class AIFortuneTellerApp extends StatelessWidget {
  const AIFortuneTellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(child: _MaterialApp());
  }
}

class _EagerInitialization extends ConsumerStatefulWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  ConsumerState<_EagerInitialization> createState() =>
      _EagerInitializationState();
}

class _EagerInitializationState extends ConsumerState<_EagerInitialization> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (_initialized) return;
    await ref.read(userInfoProvider.notifier).load(); // 사용자 정보 로드
    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final values = [ref.watch(prefsProvider), ref.watch(secureStorageProvider)];

    if (_initialized && values.every((v) => v.hasValue)) {
      return widget.child;
    }

    return const Directionality(
      textDirection: TextDirection.ltr,
      child: SplashScreenWidget(),
    );
  }
}

class _MaterialApp extends ConsumerWidget {
  const _MaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'AI Fortune Teller',
      theme: createHighContrastLightTheme(context),
      darkTheme: createHighContrastDarkTheme(context),
      themeMode: themeMode,
    );
  }
}
