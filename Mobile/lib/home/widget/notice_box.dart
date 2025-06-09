import 'package:flutter/material.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final title = "공지사항";
    final content = [
      "• 결과 공유 기능이 곧 추가될 예정입니다.",
      "• 2025년 5월 15일부터 새로운 운세 서비스가 시작됩니다.",
      "• AI 운세는 참고용으로만 활용해 주세요.",
    ];

    return Container(
      padding: EdgeInsets.all(sw * 0.03),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: sw * 0.015),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          SizedBox(height: sw * 0.02),
          ...content.map(
            (text) => Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
