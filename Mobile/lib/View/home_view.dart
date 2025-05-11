import 'package:ai_fortune_teller_app/common/default_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../setting/app_theme_provider.dart';
import 'info_input_view.dart';

class HomeView extends ConsumerStatefulWidget {
    const HomeView({super.key});

    @override
    ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
    @override
    Widget build(BuildContext context) {
        String title1 = "ChatGPT가 분석해주는";
        String title2 = "나의 사주";

        return DefaultView(child: Scaffold(
                body: GestureDetector(
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoInputView()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                        ),
                        width: double.infinity, // 전체 화면 너비
                        height: double.infinity, // 전체 화면 높이
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                                Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            ApplicationTitle(title1: title1, title2: title2)
                                        ]
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context).size.height * 0.1
                                    )
                                )
                            ]
                        )
                    )
                )
            )
        );
    }
}
class ApplicationTitle extends ConsumerWidget {
    final String title1;
    final String title2;

    const ApplicationTitle({required this.title1, required this.title2, super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        return Column(
            children: [
                IconButton(
                    icon: const Icon(Icons.brightness_6),
                    onPressed: () {
                        final notifier = ref.read(currentThemeModeProvider.notifier);
                        notifier.state = notifier.state == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark;
                    }
                ),
                Text(
                    title1,
                    style: titleStyle(context, 0.07),
                    textAlign: TextAlign.center
                ),
                Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02)),
                Text(
                    title2,
                    style: titleStyle(context, 0.09),
                    textAlign: TextAlign.center
                )
            ]
        );
    }
}


TextStyle titleStyle(BuildContext context, double fontSize) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.width * fontSize,
        color: Colors.black,
        fontWeight: FontWeight.bold
    );
}