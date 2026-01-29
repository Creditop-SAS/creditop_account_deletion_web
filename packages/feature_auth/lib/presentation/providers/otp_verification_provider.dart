import 'dart:async';

import 'package:core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:feature_auth/domain/entities/otp_verification_result.dart';
import 'package:feature_auth/domain/gateways/auth_gateway_provider.dart';
import 'package:feature_auth/presentation/providers/otp_verification_state.dart';

part 'otp_verification_provider.g.dart';

/// Provider para la lógica de verificación OTP.
@riverpod
class OtpVerificationNotifier extends _$OtpVerificationNotifier {
  Timer? _resendTimer;

  @override
  OtpVerificationState build() {
    ref.onDispose(() => _resendTimer?.cancel());
    _startResendCountdown();
    return const OtpVerificationState(resendCountdown: 60);
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!ref.mounted) {
        timer.cancel();
        return;
      }
      final newCount = state.resendCountdown - 1;
      if (newCount <= 0) {
        timer.cancel();
        state = state.copyWith(resendCountdown: 0);
      } else {
        state = state.copyWith(resendCountdown: newCount);
      }
    });
  }

  Future<bool> submitOtp(String phoneNumber) async {
    if (!PhoneValidator.isValidOtp(state.otp)) {
      state = state.copyWith(otpError: 'invalid_otp');
      return false;
    }

    state = state.copyWith(isLoading: true, clearOtpError: true);

    final (error, result) = await ref.read(authGatewayProvider).verifyOtp(
      phoneNumber,
      state.otp,
    );

    if (!ref.mounted) return false;

    if (error != null) {
      state = state.copyWith(isLoading: false, otpError: error.message);
      return false;
    }

    if (result is OtpVerificationAuthenticated) {
      state = state.copyWith(
        isLoading: false,
        session: result.session,
      );
      return true;
    }

    state = state.copyWith(
      isLoading: false,
      otpError: 'Usuario no registrado en Creditop.',
    );
    return false;
  }

  void updateOtp(String otp) {
    state = state.copyWith(otp: otp, clearOtpError: true);
  }

  Future<void> resendOtp(String phoneNumber) async {
    if (!state.canResend) return;

    await ref.read(authGatewayProvider).requestOtp(phoneNumber);

    if (!ref.mounted) return;

    state = state.copyWith(resendCountdown: 60);
    _startResendCountdown();
  }
}
