import 'package:flutter/material.dart';

import '../../tokens/cds_border_radius.dart';
import '../../tokens/cds_colors.dart';
import '../../tokens/cds_spacing.dart';
import '../../tokens/cds_typography.dart';

/// Tipo de alerta inline.
enum CtInlineAlertType { info, warning, error, success }

/// Banner de alerta inline del Creditop Design System.
class CtInlineAlert extends StatelessWidget {
  const CtInlineAlert({
    required this.message,
    this.type = CtInlineAlertType.info,
    this.icon,
    super.key,
  });

  final String message;
  final CtInlineAlertType type;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CdsSpacing.lg),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: CdsBorderRadius.borderRadiusSm,
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon ?? _defaultIcon,
            size: 20,
            color: _iconColor,
          ),
          const SizedBox(width: CdsSpacing.md),
          Expanded(
            child: Text(
              message,
              style: CdsTypography.textSmall.normal.copyWith(
                color: _textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color get _backgroundColor => switch (type) {
        CtInlineAlertType.info => CdsColors.azul.shade50,
        CtInlineAlertType.warning => CdsColors.naranja.shade50,
        CtInlineAlertType.error => CdsColors.rojo.shade50,
        CtInlineAlertType.success => CdsColors.verde.shade50,
      };

  Color get _borderColor => switch (type) {
        CtInlineAlertType.info => CdsColors.azul.shade200,
        CtInlineAlertType.warning => CdsColors.naranja.shade200,
        CtInlineAlertType.error => CdsColors.rojo.shade200,
        CtInlineAlertType.success => CdsColors.verde.shade200,
      };

  Color get _iconColor => switch (type) {
        CtInlineAlertType.info => CdsColors.azul.shade600,
        CtInlineAlertType.warning => CdsColors.naranja.shade600,
        CtInlineAlertType.error => CdsColors.rojo.shade600,
        CtInlineAlertType.success => CdsColors.verde.shade600,
      };

  Color get _textColor => switch (type) {
        CtInlineAlertType.info => CdsColors.azul.shade800,
        CtInlineAlertType.warning => CdsColors.naranja.shade800,
        CtInlineAlertType.error => CdsColors.rojo.shade800,
        CtInlineAlertType.success => CdsColors.verde.shade800,
      };

  IconData get _defaultIcon => switch (type) {
        CtInlineAlertType.info => Icons.info_outline,
        CtInlineAlertType.warning => Icons.warning_amber_rounded,
        CtInlineAlertType.error => Icons.error_outline,
        CtInlineAlertType.success => Icons.check_circle_outline,
      };
}
