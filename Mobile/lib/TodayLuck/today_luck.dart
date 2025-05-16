import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/ask_to_gpt_button.dart';

class TodayFortuneView extends StatelessWidget {
  const TodayFortuneView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final today = DateFormat('yyyy년 M월 d일').format(DateTime.now());

    final fortune = {
      "date": "2025-05-14",
      "summary": "기회와 전환점이 찾아오는 날입니다. 주저하지 말고 움직이세요.",
      "keywords": ["행동력", "도전", "새로운 시작"],
      "lucky_color": "청색",
      "lucky_number": 7,
      "lucky_direction": "남동쪽",
      "categories": {
        "general": {
          "title": "📅 종합 운세",
          "description": "오늘은 전반적으로 활력이 넘치는 하루가 될 것입니다. 새로운 일을 시작하기에 적합한 날입니다.",
        },
        "money": {
          "title": "💰 금전 운",
          "description": "불필요한 소비는 줄이고, 투자는 신중하게 접근하세요.",
        },
        "love": {
          "title": "💘 연애 운",
          "description": "솔로는 좋은 인연을 만날 기회가 있고, 커플은 감정 표현에 솔직해질 필요가 있어요.",
        },
        "health": {
          "title": "💪 건강 운",
          "description": "피로가 쌓일 수 있으니 수면을 충분히 취하고 무리한 일정은 피하세요.",
        },
      },
      "advice": "오늘은 머뭇거리는 것보다 행동으로 옮기는 것이 중요한 날입니다.",
    };

    final categories = fortune['categories'] as Map<String, dynamic>? ?? {};
    final categories2 = fortune['summary'] as String? ?? '';
    final categories3 = fortune['advice'] as String? ?? '';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                today,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: sw * 0.06,
                ),
              ),
              SizedBox(height: sh * 0.02),

              /// 📌 한줄 요약
              Card(
                elevation: 2,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(sw * 0.05),
                  child: Text(
                    categories2,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.025),

              /// 📌 키워드
              Wrap(
                spacing: 8,
                children: List<Widget>.from(
                  (fortune['keywords'] as List<dynamic>).map(
                    (word) => Chip(
                      label: Text(word),
                      backgroundColor:
                          isDark ? Colors.teal[700] : Colors.teal[50],
                      labelStyle: TextStyle(
                        color: isDark ? Colors.white : Colors.teal[800],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.025),

              /// 📌 운세 부가 정보
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Chip(
                    label: Text("행운의 색: ${fortune['lucky_color']}"),
                    backgroundColor:
                        isDark ? Colors.blue[900] : const Color(0xFFE3F2FD),
                    labelStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.blue[900],
                    ),
                  ),
                  Chip(
                    label: Text("행운의 숫자: ${fortune['lucky_number']}"),
                    backgroundColor:
                        isDark ? Colors.yellow[800] : const Color(0xFFFFF9C4),
                    labelStyle: TextStyle(
                      color: isDark ? Colors.black : Colors.brown[700],
                    ),
                  ),
                  Chip(
                    label: Text("행운의 방향: ${fortune['lucky_direction']}"),
                    backgroundColor:
                        isDark ? Colors.green[900] : const Color(0xFFE8F5E9),
                    labelStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.green[900],
                    ),
                  ),
                ],
              ),

              SizedBox(height: sh * 0.035),

              /// 📌 카테고리 카드
              for (final key in categories.keys)
                _buildCategoryCard(
                  context,
                  categories[key]['title'] ?? '',
                  categories[key]['description'] ?? '',
                ),

              /// 📌 조언
              SizedBox(height: sh * 0.035),
              _buildCategoryCard(context, "💡 오늘의 조언", categories3),

              SizedBox(height: sh * 0.04),

              Center(
                child: Text(
                  "※ 본 운세는 AI 기반 분석 결과입니다. 참고용으로 활용해주세요.",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[300] : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: sw,
                  child: getAskToGptButton(isDark, sw),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
