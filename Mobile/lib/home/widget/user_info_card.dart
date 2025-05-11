import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard(this.sw, {super.key});
  final double sw;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: sw * 0.075,
              backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300],
              child: Icon(Icons.person, size: sw * 0.1, color: Colors.white),
            ),
            SizedBox(width: sw * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '홍길동',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: sw * 0.01),
                  Text(
                    '1995.06.15 • 서울시',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: sw * 0.01),
                  Text(
                    '가입일: 2024.11.02',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}