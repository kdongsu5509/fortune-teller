import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner(this.sw, {super.key});
  final double sw;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: sw * 0.25,
      padding: EdgeInsets.all(sw * 0.03),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'AI 운세\n당신의 운명을 AI가 알려드립니다',
        style: TextStyle(
          fontSize: sw * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}