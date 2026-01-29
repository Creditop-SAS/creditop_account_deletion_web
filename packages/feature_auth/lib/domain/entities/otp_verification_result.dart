import 'auth_session.dart';

/// Resultado de la verificación de OTP.
sealed class OtpVerificationResult {
  const OtpVerificationResult();
}

/// Usuario existente autenticado exitosamente.
final class OtpVerificationAuthenticated extends OtpVerificationResult {
  const OtpVerificationAuthenticated({required this.session});

  final AuthSession session;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OtpVerificationAuthenticated && other.session == session;
  }

  @override
  int get hashCode => session.hashCode;
}
