import 'dart:developer';

import 'package:ai_fortune_teller_app/common/router.dart';
import 'package:ai_fortune_teller_app/home/widget/banner_add_box.dart';
import 'package:ai_fortune_teller_app/home/widget/notice_box.dart';
import 'package:ai_fortune_teller_app/home/widget/top_banner.dart';
import 'package:ai_fortune_teller_app/home/widget/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../setting/util/user_info_provider.dart';
import 'widget/service_card.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;

    bool isUserExit = ref.watch(userInfoProvider) != null;

    List<String> _titles = ['토정비결', '오늘의 운세', '관상', '해몽'];

    List<String> _subtitles = [
      '사주 기반 운명 분석',
      '오늘 하루 나의 운세는?',
      'AI 관상으로 로또각?',
      '꿈 해석해드립니다',
    ];

    List<String> _icons = ["📜", "📅", "🧑‍🦰", "☁️"];

    List<String> _routes = ['/saju', '/today', '/face/input', '/dream/input'];

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(sw * 0.04),
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
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              _titles.length,
              (index) => ServiceCard(
                icon: _icons[index],
                title: _titles[index],
                subtitle: _subtitles[index],
                onTap: () {
                  log(' is User Exit =>  ${isUserExit}');
                  if(!isUserExit) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('사용자 정보 등록이 필요합니다.', style: Theme.of(context).textTheme.titleMedium,),
                        content: Text('서비스를 이용하기 위해서 우선 사용자 정보를 등록해주세요.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              router.push('/settings/user');
                              Navigator.of(context).pop();
                            },
                            child: Text('확인'),
                          ),
                        ],
                      ),
                    );
                    return;
                  } else {
                    router.push(_routes[index]);
                  }
                },
              ),
            ),
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