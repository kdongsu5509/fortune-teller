import 'dart:developer';

import 'package:flutter/material.dart';

Widget getAskToGptButton(bool isDark, double sw) {
  return ElevatedButton.icon(
    onPressed: () => log("GPT에게 더 물어보기 버튼 클릭"),
    icon: const Icon(Icons.chat_bubble_outline),
    label: const Text("GPT에게 더 물어보기"),
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(sw * 0.1),
      backgroundColor: isDark ? Colors.teal[700] : Colors.teal,
    ),
  );
}
