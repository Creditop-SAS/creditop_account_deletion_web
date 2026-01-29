import 'package:cds_web/cds_web.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:feature_delete_account/presentation/models/landing_strings.dart';

/// Página de landing - info de Creditop y proceso de eliminación.
class LandingPage extends StatelessWidget {
  const LandingPage({
    required this.strings,
    required this.onStartProcess,
    super.key,
  });

  final LandingStrings strings;
  final VoidCallback onStartProcess;

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
          const SizedBox(height: CdsSpacing.md),
          Text(
            strings.description,
            style: CdsTypography.textRegular.normal.copyWith(
              color: CdsColors.neutral.shade600,
            ),
          ),
          const SizedBox(height: CdsSpacing.xl),
          _buildStep(1, strings.step1),
          _buildStep(2, strings.step2),
          _buildStep(3, strings.step3),
          _buildStep(4, strings.step4),
          const SizedBox(height: CdsSpacing.xl),
          CtButton(
            label: strings.buttonLabel,
            onPressed: onStartProcess,
          ),
          const SizedBox(height: CdsSpacing.lg),
          Center(
            child: TextButton(
              onPressed: () => launchUrl(
                Uri.parse('https://creditop.com/aviso-de-privacidad'),
                mode: LaunchMode.externalApplication,
              ),
              child: Text(
                strings.privacyPolicyLabel,
                style: CdsTypography.textSmall.medium.copyWith(
                  color: CdsColors.morado.shade500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CdsSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: CdsColors.morado.shade50,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: CdsTypography.textSmall.bold.copyWith(
                color: CdsColors.morado.shade500,
              ),
            ),
          ),
          const SizedBox(width: CdsSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: CdsSpacing.micro),
              child: Text(
                text,
                style: CdsTypography.textSmall.normal.copyWith(
                  color: CdsColors.neutral.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
