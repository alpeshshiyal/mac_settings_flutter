import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.padding});

  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
