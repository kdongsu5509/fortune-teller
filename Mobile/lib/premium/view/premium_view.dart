import 'package:flutter/material.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;
          final padding = EdgeInsets.symmetric(horizontal: isWide ? 32 : 16);

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Text(
                        '🎁 프리미엄 서비스 안내',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        '광고 없이 더 깔끔하게,\n후원으로 앱의 미래를 함께 해주세요!',
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.04),
                      Wrap(
                        runSpacing: 24,
                        spacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: isWide ? 300 : double.infinity,
                            child: PremiumOptionCard(
                              size: size.width,
                              icon: Icons.block,
                              title: '광고 제거',
                              description: '앱을 전면광고 없이 쾌적하게 이용할 수 있어요.',
                              buttonText: '광고 제거 구매하기',
                              onPressed: () {
                                // TODO: 광고 제거 로직
                              },
                            ),
                          ),
                          SizedBox(
                            width: isWide ? 300 : double.infinity,
                            child: PremiumOptionCard(
                              size: size.width,
                              icon: Icons.coffee,
                              title: '개발자 후원',
                              description:
                              '따뜻한 커피 한 잔 후원으로 앱 유지에 큰 힘이 돼요 ☕',
                              buttonText: '후원하기',
                              onPressed: () {
                                // TODO: 후원 결제 로직
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PremiumOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;
  final double size;

  const PremiumOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      color: theme.cardColor,
      elevation: isDark ? 0 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            Icon(icon, size: size * 0.2, color: theme.colorScheme.primary),
            SizedBox(height: size * 0.02),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size * 0.01),
            Text(
              description,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size * 0.02),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
