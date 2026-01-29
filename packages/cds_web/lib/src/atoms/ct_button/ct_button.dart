import 'package:flutter/material.dart';

import '../../tokens/cds_border_radius.dart';
import '../../tokens/cds_colors.dart';
import '../../tokens/cds_spacing.dart';
import '../../tokens/cds_typography.dart';

/// Variantes de botón del CDS.
enum CtButtonVariant { primary, secondary, ghost, destructive }

/// Botón del Creditop Design System para web.
class CtButton extends StatelessWidget {
  const CtButton({
    required this.label,
    required this.onPressed,
    this.variant = CtButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final CtButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _buttonStyle,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _loadingColor,
                ),
              )
            : Text(label, style: _textStyle),
      ),
    );
  }

  ButtonStyle get _buttonStyle => switch (variant) {
        CtButtonVariant.primary => ElevatedButton.styleFrom(
            backgroundColor: CdsColors.morado.shade500,
            foregroundColor: CdsColors.neutral.shade0,
            disabledBackgroundColor: CdsColors.morado.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
            ),
            padding: const EdgeInsets.symmetric(horizontal: CdsSpacing.xl),
          ),
        CtButtonVariant.secondary => ElevatedButton.styleFrom(
            backgroundColor: CdsColors.neutral.shade0,
            foregroundColor: CdsColors.morado.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
              side: BorderSide(color: CdsColors.morado.shade500),
            ),
            padding: const EdgeInsets.symmetric(horizontal: CdsSpacing.xl),
            elevation: 0,
          ),
        CtButtonVariant.ghost => ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: CdsColors.morado.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
            ),
            padding: const EdgeInsets.symmetric(horizontal: CdsSpacing.xl),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
        CtButtonVariant.destructive => ElevatedButton.styleFrom(
            backgroundColor: CdsColors.rojo.shade500,
            foregroundColor: CdsColors.neutral.shade0,
            disabledBackgroundColor: CdsColors.rojo.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
            ),
            padding: const EdgeInsets.symmetric(horizontal: CdsSpacing.xl),
          ),
      };

  TextStyle get _textStyle => CdsTypography.textRegular.bold;

  Color get _loadingColor => switch (variant) {
        CtButtonVariant.primary ||
        CtButtonVariant.destructive =>
          CdsColors.neutral.shade0,
        CtButtonVariant.secondary ||
        CtButtonVariant.ghost =>
          CdsColors.morado.shade500,
      };
}
