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

    // if (content.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("꿈 내용을 입력해 주세요.")),
    //   );
    //   return;
    // }

    // 👉 실제 AI 해몽 요청 또는 결과 화면으로 이동
    router.go('/dream/result');

  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(sw * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "🔮 어떤 꿈을 꾸셨나요?",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: sh * 0.02),
            Expanded(
              child: TextField(
                controller: _dreamContentController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "꿈 내용을 입력해 주세요.",
                  hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: isDark ? Colors.grey[900] : Colors.grey[100],
                ),
              ),
            ),
            SizedBox(height: sh * 0.03),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitDream,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("AI에게 해몽 요청하기"),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                "※ 꿈 내용을 바탕으로 AI가 유형과 해몽을 분석합니다.",
                style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[300] : Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
