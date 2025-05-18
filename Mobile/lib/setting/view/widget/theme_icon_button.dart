import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme_provider.dart';

class ThemeIconButton extends ConsumerWidget {
  ThemeIconButton({required this.onPressed, super.key});
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: onPressed,
    );
  }
}
