import 'dart:developer';

import 'package:flutter/material.dart';

import '../../common/ask_to_gpt_button.dart';
import '../../common/content_card.dart';

class SaJuResultView extends StatelessWidget {
  final Map<String, dynamic> _tempData = {
    "name": "고동수",
    "birth": "1997년 5월 14일 (음력) / 미시 출생",
    "ohaeng":
        "당신의 사주는 목(2), 화(3), 토(1), 금(1), 수(0)으로 구성되어 있으며, 수(水)의 기운이 부족한 편입니다.",
    "personality":
        "일간이 갑목(甲木)으로 태어난 당신은 강한 추진력과 리더십을 지닌 인물입니다. 때때로 감정 조절에 주의가 필요합니다.",
    "luck": "현재 대운은 무인(戊寅)으로, 새로운 기회와 전환의 시기에 있습니다.",
    "suggestion": "자연과의 접촉, 명상, 여름 기운을 활용하는 것이 좋습니다.",
  };

  SaJuResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<String> _tileTitle = [
      "🌕 출생 정보",
      "🌿 오행 분석",
      "🧠 성격",
      "🔮 대운 / 현재 운세",
      "💡 조언",
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: ListView(
          children: [
            Text(
              '🔮 ${_tempData['name']}님의 사주 분석',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            contentsCard(context, _tileTitle[0], _tempData['birth'], sw),
            contentsCard(context, _tileTitle[1], _tempData['ohaeng'], sw),
            contentsCard(context, _tileTitle[2], _tempData['personality'], sw),
            contentsCard(context, _tileTitle[3], _tempData['luck'], sw),
            contentsCard(context, _tileTitle[4], _tempData['suggestion'], sw),
            getAskToGptButton(isDark, sw),
            SizedBox(height: sw * 0.05),
            Center(
              child: Text(
                "※ 본 분석은 AI 기반 사주 결과이며 참고용입니다.",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: sw * 0.05),
          ],
        ),
      ),
    );
  }
}
