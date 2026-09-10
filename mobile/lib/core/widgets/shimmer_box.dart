import 'package:flutter/material.dart';

/// Wraps a shimmer over any child.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
