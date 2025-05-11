import 'package:ai_fortune_teller_app/setting/app_theme.dart';
import 'package:ai_fortune_teller_app/setting/app_theme_provider.dart';
import 'package:ai_fortune_teller_app/util/provider_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'DataLayer/Service/storage/prefs.dart';
import 'DataLayer/Service/storage/secure_storage.dart';
import 'common/router.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
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
        return _EagerInitialization(
            child: _MaterialApp(),
        );
    }
}

class _EagerInitialization extends ConsumerWidget {
    const _EagerInitialization({required this.child});
    final Widget child;

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        final values = [
            ref.watch(prefsProvider),
            ref.watch(secureStorageProvider),
        ];

        //ref.wathch를 사용하기 때문에 값이 바뀌면 build가 다시 호출된다.
        if (values.every((value) => value.hasValue)) {
            return child;
        }

        return const SizedBox();
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
