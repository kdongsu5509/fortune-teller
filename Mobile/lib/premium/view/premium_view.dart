import 'package:flutter/material.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.06, vertical: sh * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: sh * 0.05),
                    Text(
                      "🎁 프리미엄 서비스 안내",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: sh * 0.03),
                    const Text(
                      "원하는 방식으로 앱을 후원하거나 광고 없이 이용하세요!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: sh * 0.05),
                    _premiumOptionCard(
                      context,
                      title: "🚫 광고 제거",
                      description: "앱을 \"전면광고\" 없이 쾌적하게 이용할 수 있어요.",
                      buttonText: "광고 제거 구매하기",
                      onPressed: () {
                        // TODO: 광고 제거 IAP 로직
                      },
                      isWide: isWide,
                    ),
                    SizedBox(height: sh * 0.03),
                    _premiumOptionCard(
                      context,
                      title: "☕ 개발자에게 커피 한 잔",
                      description: "앱이 마음에 드셨다면 따뜻한 후원을 보내주세요! \n학생 개발자인 제가 이 앱을 오래 유지할 수 있어요!",
                      buttonText: "후원하기",
                      onPressed: () {
                        // TODO: 단순 후원 결제 로직
                      },
                      isWide: isWide,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _premiumOptionCard(
      BuildContext context, {
        required String title,
        required String description,
        required String buttonText,
        required VoidCallback onPressed,
        required bool isWide,
      }) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.05),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: sh * 0.01),
          Text(description),
          SizedBox(height: sh * 0.03),
          Center(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B77F5),
                foregroundColor: Colors.white,
                minimumSize: Size(isWide ? sw * 0.3 : sw * 0.6, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}