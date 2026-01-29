import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/cds_border_radius.dart';
import '../../tokens/cds_colors.dart';
import '../../tokens/cds_spacing.dart';
import '../../tokens/cds_typography.dart';

/// Text field del Creditop Design System para web.
class CtTextField extends StatelessWidget {
  const CtTextField({
    required this.controller,
    this.label,
    this.hint,
    this.prefix,
    this.errorText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? prefix;
  final String? errorText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: CdsSpacing.sm),
            child: Text(
              label!,
              style: CdsTypography.textSmall.medium.copyWith(
                color: CdsColors.neutral.shade800,
              ),
            ),
          ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          onChanged: onChanged,
          autofocus: autofocus,
          style: CdsTypography.textRegular.normal.copyWith(
            color: CdsColors.neutral.shade900,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: CdsTypography.textRegular.normal.copyWith(
              color: CdsColors.neutral.shade400,
            ),
            prefixText: prefix,
            prefixStyle: CdsTypography.textRegular.medium.copyWith(
              color: CdsColors.neutral.shade700,
            ),
            errorText: errorText,
            errorStyle: CdsTypography.textTiny.normal.copyWith(
              color: CdsColors.rojo.shade500,
            ),
            counterText: '',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: CdsSpacing.lg,
              vertical: CdsSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
              borderSide: BorderSide(color: CdsColors.neutral.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
              borderSide: BorderSide(color: CdsColors.neutral.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
              borderSide: BorderSide(
                color: CdsColors.morado.shade500,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
              borderSide: BorderSide(color: CdsColors.rojo.shade500),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: CdsBorderRadius.borderRadiusSm,
              borderSide: BorderSide(
                color: CdsColors.rojo.shade500,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
