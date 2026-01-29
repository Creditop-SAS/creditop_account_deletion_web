import 'package:core/core.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:flutter/foundation.dart';

/// Mock del gateway de autenticación para desarrollo.
/// OTP válido: "1234"
class AuthGatewayMock implements AuthGateway {
  @override
  Future<(ErrorItem?, void)> requestOtp(String phoneNumber) async {
    debugPrint('[AuthGatewayMock] requestOtp: $phoneNumber');
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Simular error para números especiales
    if (phoneNumber == '+570000000000') {
      return (
        const ErrorItem(
          code: 'user_not_found',
          title: 'Usuario no encontrado',
          message: 'Este número no está registrado en Creditop.',
          category: ErrorCategory.modal,
        ),
        null,
      );
    }

    return (null, null);
  }

  @override
  Future<(ErrorItem?, OtpVerificationResult?)> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
    debugPrint('[AuthGatewayMock] verifyOtp: $phoneNumber, code: $otpCode');
    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (otpCode != '1234') {
      return (
        const ErrorItem(
          code: 'invalid_otp',
          title: 'Código incorrecto',
          message: 'El código ingresado no es válido.',
          category: ErrorCategory.modal,
        ),
        null,
      );
    }

    return (
      null,
      const OtpVerificationAuthenticated(
        session: AuthSession(
          accessToken: 'mock-access-token',
          idToken: 'mock-id-token',
          refreshToken: 'mock-refresh-token',
        ),
      ),
    );
  }
}
