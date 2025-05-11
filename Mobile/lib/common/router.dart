import 'package:ai_fortune_teller_app/common/default_view.dart';
import 'package:ai_fortune_teller_app/home/home_view.dart';
import 'package:ai_fortune_teller_app/premium/view/premium_view.dart';
import 'package:ai_fortune_teller_app/setting/view/setting_view.dart';
import 'package:go_router/go_router.dart';
import '../Saju/view/saju_info_input.dart';

final router = GoRouter(
    initialLocation: '/',
    routes: [
        ShellRoute(
            builder: (context, state, child) => DefaultView(child: child),
            routes: [
                GoRoute(
                    path: '/',
                    builder: (_, __) => const HomeView()
                ),
                GoRoute(path: '/premium', builder: (_, __) => PremiumView()),
                GoRoute(
                    path: '/saju',
                    builder: (_, __) => InfoInputView()
                ),
                GoRoute(path: '/settings', builder: (_, __) => SettingsView())
            ]
        )
    ]
);
