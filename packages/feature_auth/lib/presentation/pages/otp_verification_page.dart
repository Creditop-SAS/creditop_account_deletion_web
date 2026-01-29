import 'package:cds_web/cds_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:feature_auth/presentation/models/otp_verification_strings.dart';
import 'package:feature_auth/presentation/providers/otp_verification_provider.dart';

/// Página de verificación OTP.
class OtpVerificationPage extends ConsumerWidget {
  const OtpVerificationPage({
    required this.phoneNumber,
    required this.strings,
    required this.onVerified,
    super.key,
  });

  final String phoneNumber;
  final OtpVerificationStrings strings;
  final VoidCallback onVerified;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otpVerificationProvider);

    ref.listen(otpVerificationProvider, (prev, next) {
      if (next.isAuthenticated && !(prev?.isAuthenticated ?? false)) {
        onVerified();
      }
    });

    return CtWebScaffold(
      body: Column(
        children: [
          Text(
            strings.title,
            style: CdsTypography.heading.xxsmall.copyWith(
              color: CdsColors.neutral.shade900,
            ),
          ),
          const SizedBox(height: CdsSpacing.sm),
          Text(
            strings.subtitle,
            style: CdsTypography.textRegular.normal.copyWith(
              color: CdsColors.neutral.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CdsSpacing.xxl),
          CtOtpInput(
            hasError: state.otpError != null,
            onCompleted: (otp) {
              ref
                  .read(otpVerificationProvider.notifier)
                  .updateOtp(otp);
            },
          ),
          if (state.otpError != null) ...[
            const SizedBox(height: CdsSpacing.sm),
            Text(
              strings.invalidOtpError,
              style: CdsTypography.textSmall.normal.copyWith(
                color: CdsColors.rojo.shade500,
              ),
            ),
          ],
          const SizedBox(height: CdsSpacing.xl),
          CtButton(
            label: strings.buttonLabel,
            isLoading: state.isLoading,
            onPressed: state.otp.length == 4 && !state.isLoading
                ? () async {
                    await ref
                        .read(otpVerificationProvider.notifier)
                        .submitOtp(phoneNumber);
                  }
                : null,
          ),
          const SizedBox(height: CdsSpacing.lg),
          state.canResend
              ? TextButton(
                  onPressed: () {
                    ref
                        .read(otpVerificationProvider.notifier)
                        .resendOtp(phoneNumber);
                  },
                  child: Text(
                    strings.resendLabel,
                    style: CdsTypography.textSmall.medium.copyWith(
                      color: CdsColors.morado.shade500,
                    ),
                  ),
                )
              : Text(
                  '${strings.resendCountdown} ${state.resendCountdown}s',
                  style: CdsTypography.textSmall.normal.copyWith(
                    color: CdsColors.neutral.shade500,
                  ),
                ),
        ],
      ),
    );
  }
}
