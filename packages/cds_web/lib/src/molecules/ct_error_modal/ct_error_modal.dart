import 'package:flutter/material.dart';

import '../../tokens/cds_border_radius.dart';
import '../../tokens/cds_colors.dart';
import '../../tokens/cds_spacing.dart';
import '../../tokens/cds_typography.dart';
import '../../atoms/ct_button/ct_button.dart';

/// Modal de error/confirmación del Creditop Design System.
class CtErrorModal extends StatelessWidget {
  const CtErrorModal({
    required this.title,
    required this.message,
    required this.primaryButtonLabel,
    required this.onPrimaryPressed,
    this.secondaryButtonLabel,
    this.onSecondaryPressed,
    this.icon,
    super.key,
  });

  final String title;
  final String message;
  final String primaryButtonLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonLabel;
  final VoidCallback? onSecondaryPressed;
  final IconData? icon;

  /// Muestra el modal como un dialog.
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required String primaryButtonLabel,
    required VoidCallback onPrimaryPressed,
    String? secondaryButtonLabel,
    VoidCallback? onSecondaryPressed,
    IconData? icon,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CtErrorModal(
        title: title,
        message: message,
        primaryButtonLabel: primaryButtonLabel,
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          onPrimaryPressed();
        },
        secondaryButtonLabel: secondaryButtonLabel,
        onSecondaryPressed: onSecondaryPressed != null
            ? () {
                Navigator.of(context).pop();
                onSecondaryPressed();
              }
            : null,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: CdsBorderRadius.borderRadiusMd,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(CdsSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 48, color: CdsColors.naranja.shade500),
              const SizedBox(height: CdsSpacing.lg),
            ],
            Text(
              title,
              style: CdsTypography.heading.xxsmall.copyWith(
                color: CdsColors.neutral.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CdsSpacing.md),
            Text(
              message,
              style: CdsTypography.textRegular.normal.copyWith(
                color: CdsColors.neutral.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CdsSpacing.xl),
            CtButton(
              label: primaryButtonLabel,
              onPressed: onPrimaryPressed,
            ),
            if (secondaryButtonLabel != null) ...[
              const SizedBox(height: CdsSpacing.md),
              CtButton(
                label: secondaryButtonLabel!,
                onPressed: onSecondaryPressed,
                variant: CtButtonVariant.ghost,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
