import 'package:flutter/material.dart';

class TodayFortuneView extends StatelessWidget {
  const TodayFortuneView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("오늘의 운세"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2025년 5월 12일",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: sh * 0.02),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(sw * 0.05),
                child: Text(
                  "오늘은 당신에게 큰 기회가 찾아올 수 있는 날입니다. 긍정적인 에너지를 유지하고 주변 사람들과의 협력을 통해 더 좋은 결과를 만들어보세요.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: sh * 0.03),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Chip(
                  label: const Text("행운의 색: 파란색"),
                  backgroundColor: isDark ? Colors.blue[900] : const Color(0xFFE3F2FD),
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.blue[900],
                  ),
                ),
                Chip(
                  label: const Text("행운의 숫자: 8"),
                  backgroundColor: isDark ? Colors.yellow[800] : const Color(0xFFFFF9C4),
                  labelStyle: TextStyle(
                    color: isDark ? Colors.black : Colors.brown[700],
                  ),
                ),
                Chip(
                  label: const Text("피해야 할 행동: 성급한 판단"),
                  backgroundColor: isDark ? Colors.red[900] : const Color(0xFFFFEBEE),
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.red[900],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Text(
                "※ 본 운세는 AI 기반 분석 결과입니다. 참고용으로 활용해주세요.",
                style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[300] : Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}