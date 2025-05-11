import 'package:flutter/material.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox(this.sw, {super.key});
  final double sw;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              Icon(Icons.info_outline, size: 16, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: sw * 0.015),
              Text('공지사항', style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          SizedBox(height: sw * 0.02),
          ...[
            '• 결과 공유 기능이 곧 추가될 예정입니다.',
            '• 2025년 5월 15일부터 새로운 운세 서비스가 시작됩니다.',
            '• AI 운세는 참고용으로만 활용해 주세요.',
          ].map((text) => Text(text, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}
