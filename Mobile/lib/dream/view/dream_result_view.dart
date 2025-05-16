import 'package:ai_fortune_teller_app/common/ask_to_gpt_button.dart';
import 'package:flutter/material.dart';

class DreamResultView extends StatelessWidget {
  const DreamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

    final dream = {
      "summary": "이 꿈은 새로운 시작이나 변화에 대한 당신의 내면 의지를 반영합니다.",
      "dream_type": "비행 꿈",
      "symbol_meanings": [
        {"symbol": "하늘을 나는 장면", "meaning": "자유에 대한 갈망과 현실을 벗어나고 싶은 욕구를 나타냅니다."},
        {"symbol": "높은 곳에서 내려다봄", "meaning": "자기 자신을 객관적으로 바라보려는 태도를 의미합니다."},
      ],
      "advice": "지금이 새로운 도전을 시작하기에 좋은 시점입니다. 두려워 말고 도전해보세요.",
    };

    final symbols = dream['symbol_meanings'] as List<dynamic>? ?? [];
    final dreamSummary = dream['summary'] as String? ?? '';
    final dreamAdvice = dream['advice'] as String? ?? '';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 꿈 유형
              Text(
                "🌙 꿈의 유형: ${dream['dream_type']}",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: sh * 0.015),

              /// 해몽 요약
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(sw * 0.05),
                  child: Text(
                    dreamSummary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: sh * 0.03),

              /// 상징별 해석
              Text(
                "🔍 주요 장면 해석",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              for (final item in symbols)
                _buildSymbolCard(context, item['symbol'], item['meaning']),

              SizedBox(height: sh * 0.035),

              /// 조언
              _buildSymbolCard(context, "💡 조언", dreamAdvice),

              getAskToGptButton(isDark, sw),
              SizedBox(height: 32),
              Center(
                child: Text(
                  "※ 본 해몽은 AI 분석 결과이며 참고용입니다.",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[300] : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymbolCard(BuildContext context, String title, String meaning) {
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
              Text(meaning, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
