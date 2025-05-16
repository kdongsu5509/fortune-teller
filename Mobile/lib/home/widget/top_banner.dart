import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final _title = 'AI로\n당신의 운명을 알려드립니다';

    return Container(
      height: sw * 0.25,
      padding: EdgeInsets.all(sw * 0.03),
      alignment: Alignment.bottomLeft,
      child: Text(
        _title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
