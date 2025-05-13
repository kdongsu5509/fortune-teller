import 'dart:developer';

import 'package:flutter/material.dart';

class SaJuResultView extends StatelessWidget {
  final Map<String, dynamic> data = {
    "name": "고동수",
    "birth": "1997년 5월 14일 (음력) / 미시 출생",
    "ohaeng": "당신의 사주는 목(2), 화(3), 토(1), 금(1), 수(0)으로 구성되어 있으며, 수(水)의 기운이 부족한 편입니다.",
    "personality": "일간이 갑목(甲木)으로 태어난 당신은 강한 추진력과 리더십을 지닌 인물입니다. 때때로 감정 조절에 주의가 필요합니다.",
    "luck": "현재 대운은 무인(戊寅)으로, 새로운 기회와 전환의 시기에 있습니다.",
    "suggestion": "자연과의 접촉, 명상, 여름 기운을 활용하는 것이 좋습니다.",
  };

  SaJuResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: ListView(
          children: [
            Text(
              '🔮 ${data['name']}님의 사주 분석',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            _buildSectionCard(context, "🌕 출생 정보", data['birth']),
            _buildSectionCard(context, "🌿 오행 분석", data['ohaeng']),
            _buildSectionCard(context, "🧠 성격", data['personality']),
            _buildSectionCard(context, "🔮 대운 / 현재 운세", data['luck']),
            _buildSectionCard(context, "💡 조언", data['suggestion']),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => log("GPT에게 더 물어보기 버튼 클릭"),
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text("GPT에게 더 물어보기"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: isDark ? Colors.teal[700] : Colors.teal,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                "※ 본 분석은 AI 기반 사주 결과이며 참고용입니다.",
                style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[300] : Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(content, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
