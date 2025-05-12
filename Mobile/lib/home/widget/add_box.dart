import 'package:flutter/material.dart';

class AddBox extends StatelessWidget {
  const AddBox(this.height, {super.key});

  final height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;

    return Container(
      height: sw * height,
      padding: EdgeInsets.all(sw * 0.03),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: Text(
        '광고',
        style: TextStyle(
          fontSize: sw * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
