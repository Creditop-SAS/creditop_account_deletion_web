import 'package:core/core.dart';

import '../entities/otp_verification_result.dart';

/// Gateway para operaciones de autenticación con Cognito Custom Auth + OTP.
abstract class AuthGateway {
  /// Solicita envío de OTP al [phoneNumber] (formato: +573001234567).
  Future<(ErrorItem?, void)> requestOtp(String phoneNumber);

  /// Verifica el [otpCode] para el [phoneNumber].
  Future<(ErrorItem?, OtpVerificationResult?)> verifyOtp(
    String phoneNumber,
    String otpCode,
  );
}
