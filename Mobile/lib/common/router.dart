import 'package:ai_fortune_teller_app/Saju/view/saju_result_view.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_fortune_teller_app/common/default_view.dart';
import 'package:ai_fortune_teller_app/home/home_view.dart';
import 'package:ai_fortune_teller_app/premium/view/premium_view.dart';
import 'package:ai_fortune_teller_app/TodayLuck/today_luck.dart';
import 'package:ai_fortune_teller_app/setting/view/setting_view.dart';
import 'package:ai_fortune_teller_app/setting/view/user_info_update_view.dart';
import 'package:ai_fortune_teller_app/setting/view/privacy_policy_view.dart';

import '../Face/view/face_analysis_view.dart';
import '../dream/view/dream_input_view.dart';
import '../dream/view/dream_result_view.dart';
import '../face/view/face_input_view.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => DefaultView(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeView()),
        GoRoute(path: '/premium', builder: (_, __) => const PremiumView()),
        GoRoute(path: '/saju', builder: (_, __) => SaJuResultView()),
        GoRoute(path: '/today', builder: (_, __) => const TodayFortuneView()),
        GoRoute(path: '/face/input', builder: (_, __) => FaceInputView()),
        GoRoute(path: '/face/result', builder: (_, __) => FaceAnalysisView()),
        GoRoute(
          path: '/dream/input',
          builder: (_, __) => const DreamInputView(),
        ),
        GoRoute(
          path: '/dream/result',
          builder: (_, __) => const DreamResultView(),
        ),
        GoRoute(path: '/settings', builder: (_, __) => SettingsView()),
        GoRoute(
          path: '/settings/user',
          builder: (_, __) => const UserInfoUpdateView(),
        ),
        GoRoute(
          path: '/settings/privacy',
          builder: (_, __) => const PrivacyPolicyView(),
        ),
      ],
    ),
  ],
);
