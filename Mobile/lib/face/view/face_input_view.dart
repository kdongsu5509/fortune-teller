import 'dart:developer';

import 'package:ai_fortune_teller_app/common/router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceInputView extends StatefulWidget {
  const FaceInputView({super.key});

  @override
  State<FaceInputView> createState() => _FaceInputViewState();
}

class _FaceInputViewState extends State<FaceInputView> {
  void _pickImage({required String source}) async {
    if(source == 'camera') {
    } else {
    }

    log("구현 필요");
    router.go('/face/result');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: sh * 0.05),
            Icon(Icons.face_retouching_natural, size: 100, color: isDark ? Colors.white70 : Colors.indigo),
            SizedBox(height: 24),
            Text(
              "관상 분석에 사용할 사진을 선택하거나\n직접 촬영해 주세요.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sh * 0.06),

            ElevatedButton.icon(
              icon: const Icon(Icons.photo_camera),
              label: const Text("사진 촬영하기"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _pickImage(source: 'camera'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text("앨범에서 선택하기"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                foregroundColor: isDark ? Colors.white : Colors.black87,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _pickImage(source: 'gallery'),
            ),
            const Spacer(),
            const Text(
              "※ 얼굴이 잘 보이도록 정면 사진을 권장합니다.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
