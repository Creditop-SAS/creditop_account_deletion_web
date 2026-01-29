import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cds_web/src/tokens/cds_border_radius.dart';
import 'package:cds_web/src/tokens/cds_colors.dart';
import 'package:cds_web/src/tokens/cds_shadow.dart';
import 'package:cds_web/src/tokens/cds_spacing.dart';
import 'package:cds_web/src/tokens/cds_typography.dart';

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
                      borderRadius: CdsBorderRadius.borderRadiusMd,
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
    return SvgPicture.asset(
      'assets/logos/creditop_logo.svg',
      package: 'cds_web',
      height: 30,
    );
  }

  Widget _buildFooter() {
    return Text(
      '\u00a9 2026 Creditop S.A.S. Todos los derechos reservados.',
      style: CdsTypography.textTiny.normal.copyWith(
        color: CdsColors.neutral.shade500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
