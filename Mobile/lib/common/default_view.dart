import 'package:flutter/material.dart';

class DefaultView extends StatelessWidget {
  const DefaultView({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default View'),
      ),
      body: Center(
        child: child
      ),
    );
  }
}
