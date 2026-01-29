import 'package:flutter/foundation.dart';

import '../../domain/entities/auth_session.dart';

/// Estado de la página de verificación OTP.
@immutable
final class OtpVerificationState {
  const OtpVerificationState({
    this.otp = '',
    this.isLoading = false,
    this.otpError,
    this.session,
    this.resendCountdown = 0,
  });

  final String otp;
  final bool isLoading;
  final String? otpError;
  final AuthSession? session;
  final int resendCountdown;

  bool get isAuthenticated => session != null;
  bool get canResend => resendCountdown == 0;

  OtpVerificationState copyWith({
    String? otp,
    bool? isLoading,
    String? otpError,
    AuthSession? session,
    int? resendCountdown,
    bool clearOtpError = false,
    bool clearSession = false,
  }) {
    return OtpVerificationState(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      otpError: clearOtpError ? null : (otpError ?? this.otpError),
      session: clearSession ? null : (session ?? this.session),
      resendCountdown: resendCountdown ?? this.resendCountdown,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OtpVerificationState &&
        other.otp == otp &&
        other.isLoading == isLoading &&
        other.otpError == otpError &&
        other.session == session &&
        other.resendCountdown == resendCountdown;
  }

  @override
  int get hashCode => Object.hash(
        otp,
        isLoading,
        otpError,
        session,
        resendCountdown,
      );
}
