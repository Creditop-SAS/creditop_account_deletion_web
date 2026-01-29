import 'package:cds_web/cds_web.dart';
import 'package:flutter/material.dart';

import '../models/data_info_strings.dart';

/// Página de información de datos - qué se elimina vs qué se conserva.
class DataInfoPage extends StatelessWidget {
  const DataInfoPage({
    required this.strings,
    required this.onContinue,
    required this.onCancel,
    super.key,
  });

  final DataInfoStrings strings;
  final VoidCallback onContinue;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return CtWebScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.title,
            style: CdsTypography.heading.xxsmall.copyWith(
              color: CdsColors.neutral.shade900,
            ),
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtDataInfoSection(
            icon: Icons.delete_outline,
            iconColor: CdsColors.rojo.shade500,
            title: strings.deletedDataTitle,
            items: strings.deletedDataItems,
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtDataInfoSection(
            icon: Icons.shield_outlined,
            iconColor: CdsColors.azul.shade600,
            title: strings.retainedDataTitle,
            items: strings.retainedDataItems,
          ),
          const SizedBox(height: CdsSpacing.md),
          CtInlineAlert(
            message: strings.retainedDataNote,
            type: CtInlineAlertType.info,
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtButton(
            label: strings.continueButtonLabel,
            onPressed: onContinue,
          ),
          const SizedBox(height: CdsSpacing.md),
          CtButton(
            label: strings.cancelButtonLabel,
            onPressed: onCancel,
            variant: CtButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}
