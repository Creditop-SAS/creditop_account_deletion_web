import 'package:flutter/material.dart';

import 'package:cds_web/src/tokens/cds_colors.dart';

/// Loader circular del Creditop Design System.
class CtLoader extends StatelessWidget {
  const CtLoader({
    this.size = 40,
    this.strokeWidth = 3,
    super.key,
  });

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: CdsColors.morado.shade500,
      ),
    );
  }
}
