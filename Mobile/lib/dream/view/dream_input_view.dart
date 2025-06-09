import 'package:flutter/material.dart';
import '../../common/router.dart';

class DreamInputView extends StatefulWidget {
    const DreamInputView({super.key});

    @override
    State<DreamInputView> createState() => _DreamInputViewState();
}

class _DreamInputViewState extends State<DreamInputView> {
    final TextEditingController _dreamContentController = TextEditingController();

    @override
    void dispose() {
        _dreamContentController.dispose();
        super.dispose();
    }

    void _submitDream() {
        final content = _dreamContentController.text.trim();
        if (content.isNotEmpty) {
            router.go('/dream/result');
        } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('꿈 내용을 입력해 주세요.'))
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final size = MediaQuery.of(context).size;
        final sw = size.width;
        final sh = size.height;

        final pageTitle = "🔮 어떤 꿈을 꾸셨나요?";
        final pageDescription = "자세하게 적을수록 정확한 해몽이 가능해요!";
        final hintText = "예: 높은 곳에서 떨어지는 꿈을 꾸었어요...";
        final buttonText = "AI에게 해몽 요청하기";
        final pageFooterDescription = "※ 꿈 내용을 바탕으로 AI가 유형과 해몽을 분석합니다.";

        return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.06, vertical: sh * 0.03),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                pageTitle,
                                style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            SizedBox(height: sh * 0.02),
                            Text(
                                pageDescription,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isDark ? Colors.grey[400] : Colors.grey[700]
                                )
                            ),
                            SizedBox(height: sh * 0.02),
                            Expanded(
                                child: TextField(
                                    controller: _dreamContentController,
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    style: theme.textTheme.bodyMedium,
                                    decoration: InputDecoration(
                                        hintText: hintText,
                                        hintStyle: TextStyle(
                                            color: isDark ? Colors.grey[500] : Colors.grey[600]
                                        ),
                                        filled: true,
                                        fillColor: isDark ? Colors.grey[900] : Colors.grey[100],
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide.none
                                        ),
                                        contentPadding: const EdgeInsets.all(16)
                                    )
                                )
                            ),
                            SizedBox(height: sh * 0.02),
                            SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: _submitDream,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colorScheme.primary,
                                        foregroundColor: theme.colorScheme.onPrimary,
                                        textStyle: theme.textTheme.bodyMedium,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        )
                                    ),
                                    child: Text(buttonText)
                                )
                            ),
                            SizedBox(height: sh * 0.02),
                            Center(
                                child: Text(
                                    pageFooterDescription,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: isDark ? Colors.grey[300] : Colors.grey[600]
                                    ),
                                    textAlign: TextAlign.center
                                )
                            )
                        ]
                    )
                )
            )
        );
    }
}
