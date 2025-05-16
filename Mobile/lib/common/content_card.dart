import 'package:flutter/material.dart';

Widget contentsCard(BuildContext context, String title, String content, double sw) {
  return Padding(
    padding: EdgeInsets.only(bottom: sw * 0.04),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(sw * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: sw * 0.015),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    ),
  );
}