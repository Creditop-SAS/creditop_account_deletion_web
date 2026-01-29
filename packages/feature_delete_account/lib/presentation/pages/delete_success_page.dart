import 'package:cds_web/cds_web.dart';
import 'package:flutter/material.dart';

import '../models/delete_success_strings.dart';

/// Página de eliminación exitosa.
class DeleteSuccessPage extends StatelessWidget {
  const DeleteSuccessPage({
    required this.strings,
    required this.onDone,
    super.key,
  });

  final DeleteSuccessStrings strings;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return CtWebScaffold(
      body: Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: CdsColors.verde.shade500,
          ),
          const SizedBox(height: CdsSpacing.lg),
          Text(
            strings.title,
            style: CdsTypography.heading.xxsmall.copyWith(
              color: CdsColors.neutral.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CdsSpacing.md),
          Text(
            strings.message,
            style: CdsTypography.textRegular.normal.copyWith(
              color: CdsColors.neutral.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CdsSpacing.lg),
          CtInlineAlert(
            message: strings.retainedDataNote,
            type: CtInlineAlertType.info,
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtButton(
            label: strings.buttonLabel,
            onPressed: onDone,
          ),
        ],
      ),
    );
  }
}
