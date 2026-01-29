import 'package:flutter/material.dart';

import 'package:cds_web/src/tokens/cds_colors.dart';
import 'package:cds_web/src/tokens/cds_spacing.dart';
import 'package:cds_web/src/tokens/cds_typography.dart';

/// Sección de información de datos con icono, título y lista de items.
class CtDataInfoSection extends StatelessWidget {
  static const double _itemIndent = 36.0;

  const CtDataInfoSection({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.items,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: CdsSpacing.md),
            Text(
              title,
              style: CdsTypography.textRegular.bold.copyWith(
                color: CdsColors.neutral.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: CdsSpacing.md),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(
              left: _itemIndent,
              bottom: CdsSpacing.sm,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 7),
                  decoration: BoxDecoration(
                    color: CdsColors.neutral.shade400,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: CdsSpacing.sm),
                Expanded(
                  child: Text(
                    item,
                    style: CdsTypography.textSmall.normal.copyWith(
                      color: CdsColors.neutral.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
