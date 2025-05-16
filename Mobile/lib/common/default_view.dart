import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../setting/app_theme_provider.dart';
import '../setting/view/widget/theme_icon_button.dart';

class DefaultView extends ConsumerStatefulWidget {
  final Widget child;
  const DefaultView({required this.child, super.key});

  @override
  ConsumerState<DefaultView> createState() => _DefaultViewState();
}

class _DefaultViewState extends ConsumerState<DefaultView> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor:
              Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B77F5), Color(0xFF8A6AD4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: sw * 0.125),
              const Text(
                "AI Fortune Teller",
                style: TextStyle(fontFamily: "Lobster"),
              ),
              ThemeIconButton(
                onPressed: () {
                  final currentThemeMode = ref.read(currentThemeModeProvider);
                  ref.read(currentThemeModeProvider.notifier).state =
                      currentThemeMode == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                },
              ),
            ],
          ),
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: _getSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/premium');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
        selectedItemColor: const Color(0xFF5B77F5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: '프리미엄',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/premium')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }
}
