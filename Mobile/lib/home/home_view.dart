import 'package:ai_fortune_teller_app/common/router.dart';
import 'package:ai_fortune_teller_app/home/widget/banner_add_box.dart';
import 'package:ai_fortune_teller_app/home/widget/notice_box.dart';
import 'package:ai_fortune_teller_app/home/widget/top_banner.dart';
import 'package:ai_fortune_teller_app/home/widget/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widget/service_card.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TopBanner(),
          SizedBox(height: sw * 0.03),
          UserInfoCard(sw),
          SizedBox(height: sw * 0.03),
          BannerAddBox(0.15),
          SizedBox(height: sw * 0.04),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ServiceCard(
                icon: "📜",
                title: '토정비결',
                subtitle: '사주 기반 운명 분석',
                onTap: () {
                  router.push('/saju');
                },
              ),
              ServiceCard(
                icon: "📅",
                title: '오늘의 운세',
                subtitle: '오늘 하루 나의 운세는?',
                onTap: () {
                  router.push('/today');
                },
              ),
              ServiceCard(
                icon: "🧑‍🦰",
                title: '관상',
                subtitle: 'AI 관상으로 로또각?',
                onTap: () {
                  router.push('/face/result');
                },
              ),
              ServiceCard(
                icon: "☁️",
                title: '해몽',
                subtitle: '꿈 해석해드립니다',
                onTap: () {
                  router.push('/dream');
                },
              ),
            ],
          ),
          SizedBox(height: sw * 0.03),
          BannerAddBox(0.3),
          SizedBox(height: sw * 0.03),
          NoticeBox(),
        ],
      ),
    );
  }
}
