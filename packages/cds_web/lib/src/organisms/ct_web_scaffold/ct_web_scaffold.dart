import 'package:flutter/material.dart';

import '../../tokens/cds_colors.dart';
import '../../tokens/cds_shadow.dart';
import '../../tokens/cds_spacing.dart';
import '../../tokens/cds_typography.dart';

/// Layout responsive centrado para web del Creditop Design System.
///
/// Mobile (<600px): full-width, padding 16px
/// Desktop (>600px): card centrada max-width 480px, fondo neutral.shade50
class CtWebScaffold extends StatelessWidget {
  const CtWebScaffold({
    required this.body,
    this.showLogo = true,
    this.showFooter = true,
    super.key,
  });

  final Widget body;
  final bool showLogo;
  final bool showFooter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CdsColors.neutral.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CdsSpacing.lg,
                vertical: CdsSpacing.xl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showLogo) ...[
                    _buildLogo(),
                    const SizedBox(height: CdsSpacing.xl),
                  ],
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(CdsSpacing.xl),
                    decoration: BoxDecoration(
                      color: CdsColors.neutral.shade0,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: CdsShadow.md,
                    ),
                    child: body,
                  ),
                  if (showFooter) ...[
                    const SizedBox(height: CdsSpacing.xl),
                    _buildFooter(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Text(
      'Creditop',
      style: CdsTypography.heading.small.copyWith(
        color: CdsColors.morado.shade500,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildFooter() {
    return Text(
      '\u00a9 2025 Creditop S.A.S. Todos los derechos reservados.',
      style: CdsTypography.textTiny.normal.copyWith(
        color: CdsColors.neutral.shade500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
